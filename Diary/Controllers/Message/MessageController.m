//
//  MessageController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "MessageController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "NewsCell.h"
#import "NotifationCell.h"
#import "PersonCell.h"
#import "AdressBookController.h"
#import "NotifationController.h"
#import "BaseNavigation.h"
#import "SPKitExample.h"
#import <WXOUIModule/YWConversationListViewController.h>
#import <WXOUIModule/IYWUIService.h>
#import <WXOpenIMSDKFMWK/IYWConversationService.h>

@interface MessageController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation MessageController{
    
    UITableView* _tableView;
    NSIndexPath * _lastSelectCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView{
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - NavigationBarHeight - TabBarHeight )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.backgroundColor = BGViewGray;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    id<IYWConversationService> conversationService = [[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService];
    [conversationService asyncFetchAllConversationsWithCompletionBlock:^(NSArray *aConversationsArray) {
        
        self.conversationArry = [NSMutableArray arrayWithArray:aConversationsArray];
        [self.view addSubview:_tableView];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2 + _conversationArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 56.5;
            break;
            
        case 1:
            return 69;
            break;
            
        default:
            return 66.5;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            static NSString* notifationCellid = @"notifationCellid";
            NotifationCell * notifationCell = [tableView dequeueReusableCellWithIdentifier:notifationCellid];
            if (!notifationCell) {
                notifationCell =
                [[NotifationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:notifationCellid];
                notifationCell.backgroundColor = BGViewColor;
                notifationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return notifationCell;
        }
            
            break;
        case 1:{
            
            static NSString* personCellid = @"personCellid";
            PersonCell * personCell = [tableView dequeueReusableCellWithIdentifier:personCellid];
            if (!personCell) {
                personCell =
                [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:personCellid];
                personCell.backgroundColor = BGViewColor;
                personCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return personCell;
        }
            
            break;
            
        default:{
            static NSString* newsCellid = @"newsCellid";
            NewsCell * newsCell = [tableView dequeueReusableCellWithIdentifier:newsCellid];
            if (!newsCell) {
                newsCell =
                [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:newsCellid];
                newsCell.backgroundColor = BGViewColor;
                newsCell.selectionStyle = UITableViewCellSelectionStyleNone;
               
            }
           
            [newsCell bindConversation:_conversationArry[indexPath.row - 2]];
            return newsCell;
        }
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 1) {
        return YES;
    }
    return NO;
}

//协议中定义的方法，用于返回确认删除的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//协议中的方法，在真的删除或插入时被调用
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除单个会话
    YWConversation *conversation = _conversationArry[indexPath.row - 2];
    id<IYWConversationService> conversationService = [[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService];
    if ([conversationService removeConversationByConversationId:conversation.conversationId error:nil]) {
        [_conversationArry removeObjectAtIndex:indexPath.row - 2];
        [_tableView reloadData];
        [ToastManager showToast:@"删除成功！" containerView:_tableView withTime:Toast_Hide_TIME];
    }else
        
        [ToastManager showToast:@"删除失败！" containerView:_tableView withTime:Toast_Hide_TIME];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
            NotifationController *notifationVc = [NotifationController new];
            notifationVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:notifationVc animated:YES];
        }
            
            break;
        case 1:{
            
            AdressBookController *adressBookVc = [AdressBookController new];
            adressBookVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:adressBookVc animated:YES];
        }
            break;
            
        default:{
            if ([_conversationArry[indexPath.row -2] isKindOfClass:[YWP2PConversation class]]) {
                YWP2PConversation *conversation = _conversationArry[indexPath.row - 2];
                [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithPerson:conversation.person fromNavigationController:self.navigationController];
            }else if ([_conversationArry[indexPath.row - 2] isKindOfClass:[YWTribeConversation class]]){
                
                YWTribeConversation *targetConversation = _conversationArry[indexPath.row - 2];
                [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithTribe:targetConversation.tribe fromNavigationController:self.navigationController];
            }else{
                
                return;
            }

        }
            break;
    }
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有活动哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor greenColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:@"消息"];
    [self initView];
}

@end
