//
//  SPContactProfileController.m
//  WXOpenIMSampleDev
//
//  Created by sidian on 15/11/24.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "SPContactProfileController.h"
#import <WXOUIModule/YWIMKit.h>
#import <WXOpenIMSDKFMWK/YWFMWK.h>
#import "SPUtil.h"
#import "UISwitch+BlockSupport.h"

static NSString *reuseIdentifier = @"spContactProfileCell";

@interface SPContactProfileController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rowCountArray;       //number of rows in section index;

@property (nonatomic, weak) YWIMKit *imkit;
@property (nonatomic, weak) YWPerson *contact;

@end

@implementation SPContactProfileController

- (id)initWithContact:(YWPerson *)contact IMKit:(YWIMKit *)imkit
{
    self = [super init];
    if (self) {
        _imkit = imkit;
        _contact = contact;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self doLoadWork];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:_tableView];
    
       self.navigationController.navigationBarHidden = YES;
    if ([self respondsToSelector:@selector(wantsFullScreenLayout)]) {
        [self wantsFullScreenLayout];
    } else if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
       self.edgesForExtendedLayout                   = UIRectEdgeAll;
    }
}

- (void)doLoadWork
{
    if ([[_imkit.IMCore getConversationService] fetchConversationByConversationId:_contact.personLongId] == nil) {
        self.rowCountArray = @[@(1), @(1), @(1)];
    } else {
        self.rowCountArray = @[@(1), @(1), @(1), @(1)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_rowCountArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < [_rowCountArray count]) {
        return [_rowCountArray[section] integerValue];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 250.f;
            break;
            
        default:
            return 55.f;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *subviews = [cell.contentView.subviews copy];
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.contentView.backgroundColor = BGViewGreen;
            
            CGFloat windowWidth = [UIScreen mainScreen].bounds.size.width;
            CGFloat imageWidth = 66.f;
            UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((windowWidth - imageWidth)/2, (250.f - imageWidth)/2, imageWidth, imageWidth)];
            avatarView.layer.cornerRadius = imageWidth/2;
            avatarView.clipsToBounds = YES;
            avatarView.backgroundColor = [UIColor clearColor];
            
            [cell.contentView addSubview:avatarView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,135.f + imageWidth/2 , windowWidth, 20.f)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = BGViewColor;
            [cell.contentView addSubview:label];
            
            __block NSString *displayName = nil;
            __block UIImage *avatar = nil;
            //  SPUtil中包含的功能都是Demo中需要的辅助代码，在你的真实APP中一般都需要替换为你真实的实现。
            [[SPUtil sharedInstance] syncGetCachedProfileIfExists:_contact completion:^(BOOL aIsSuccess, YWPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage) {
                displayName = aDisplayName;
                avatar = aAvatarImage;
            }];
            
            if (!avatar) {
                avatar = [UIImage imageNamed:@"demo_head_120"];
            }
            if (!displayName) {
                displayName = _contact.personId;
                
                __weak __typeof(self) weakSelf = self;
                [[SPUtil sharedInstance] asyncGetProfileWithPerson:_contact
                                                          progress:^(YWPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage) {
                                                              if (aDisplayName) {
                                                                  [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                              }
                                                          } completion:^(BOOL aIsSuccess, YWPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage) {
                                                              if (aDisplayName) {
                                                                  [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                              }
                                                          }];
            }
            avatarView.image = avatar;
            label.text = displayName;
            
            UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 40, 20)];
            [exitButton setTitle:@"关闭" forState:UIControlStateNormal];
            [exitButton setBackgroundColor:[UIColor clearColor]];
            [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:exitButton];
        }
            break;
        case 1:
        {
            if ([[_imkit.IMCore getContactService] isPersonInBlackList:_contact]) {
                cell.textLabel.text = @"移出黑名单";
            } else {
                cell.textLabel.text = @"加入黑名单";
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"接收后台推送";
            UISwitch *theSwitch = [[UISwitch alloc] initWithFrame:cell.frame];
            cell.accessoryView = theSwitch;
            
            if ([[_imkit.IMCore getSettingService] getMessagePushEnableForPerson:_contact]) {
                [theSwitch setOn:YES];
            } else {
                [theSwitch setOn:NO];
            }
            
            __weak typeof(self) weakSelf = self;
            __weak typeof(theSwitch) weakSwitch = theSwitch;
            [theSwitch addblock:^{
                [[weakSelf.imkit.IMCore getSettingService] asyncSetMessagePushEnable:weakSwitch.on ForPerson:weakSelf.contact completion:^(NSError *aError, NSDictionary *aResult) {
                    if (aError != nil) {
                        theSwitch.on = !theSwitch.on;
                    }
                    NSString *title = nil;
                    if (theSwitch.on) {
                        title = @"打开后台推送";
                    } else {
                        title = @"关闭后台推送";
                    }
                    [[SPUtil sharedInstance] showNotificationInViewController:weakSelf title:title subtitle:aError ? @"失败" : @"成功" type:SPMessageNotificationTypeMessage];
                }];
            } forControlEvents:UIControlEventValueChanged];

        }
            break;
        case 3:
        {
            cell.textLabel.text = @"清空聊天记录";
        }
            
        default:
            break;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak typeof(self) weakSelf = self;

    switch (indexPath.section) {
        case 1:
        {
            if ([[_imkit.IMCore getContactService] isPersonInBlackList:_contact]) {
                [[_imkit.IMCore getContactService] removePersonFromBlackList:_contact withResultBlock:^(NSError *error, YWPerson *person) {
                    if (error == nil) {
                        [weakSelf.tableView reloadData];
                    }
                }];
            } else {
                [[_imkit.IMCore getContactService] addPersonToBlackList:_contact withResultBlock:^(NSError *error, YWPerson *person) {
                    if (error == nil) {
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }
            break;
        case 3:
        {
            YWConversation *conversation = (YWP2PConversation *)[[_imkit.IMCore getConversationService] fetchConversationByConversationId:_contact.personLongId];
            [conversation removeAllLocalMessages];
            [[SPUtil sharedInstance] showNotificationInViewController:weakSelf title:@"清空聊天记录" subtitle:@"成功" type:SPMessageNotificationTypeMessage];
            
        }
            break;
        default:
            break;
    }
}


- (void)exit
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end