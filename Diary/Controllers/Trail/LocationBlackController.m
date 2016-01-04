//
//  LocationBlackController.m
//  Diary
//
//  Created by 我 on 15/12/31.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LocationBlackController.h"
#import "BaseNavigation.h"
#import "AOTag.h"
#import "OtherTrailController.h"

#define tagMargin           13
#define tagKW              (Screen_Width - 5*13 - 32)/4
#define tagkH              ((Screen_Width - 5*13 - 32)/4 + 35)
@interface LocationBlackController () <AOTagDelegate>
@property (nonatomic, strong) AOTagList *tag;
@property (nonatomic, strong) NSMutableArray *randomTag;

@end

@implementation LocationBlackController{
    UILabel *_remindLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

- (void)initView{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = BGViewColor;
    
    [self resetRandomTagsName];
    
    self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0,
                                                           0,
                                                           Screen_Width,
                                                           Screen_height)];
    
    [self.tag setDelegate:self];
    [self.view addSubview:self.tag];
    self.view.backgroundColor = BGViewGray;
    
    _remindLabel = [UILabel new];
    _remindLabel.frame= CGRectMake(20, tagkH + 50, 300, 15);
    _remindLabel.text = @"添加入黑名单后TA将不会看到您的位置";
    _remindLabel.font = FONT_SIZE_15;
    _remindLabel.textColor = COLOR_GRAY_DEFAULT_47;
    [self.view addSubview:_remindLabel];
}

- (void)resetRandomTagsName
{
    [self.tag removeAllTag];
    
    self.randomTag = [NSMutableArray arrayWithArray:@[@{@"title": @"Tyrion", @"image": @"pic_bg"}, @{@"title": @"Jaime", @"image": @"pic_bg"}, @{@"title": @"Robert", @"image": @"pic_bg"}, @{@"title": @"Sansa", @"image": @"pic_bg"}, @{@"title": @"Arya", @"image": @"pic_bg"}, @{@"title": @"Jon", @"image": @"pic_bg"}, @{@"title": @"Catelyn", @"image": @"pic_bg"}, @{@"title": @"Cersei", @"image": @"pic_bg"}]];
}

#pragma mark -- AOTagDelegate
- (void)tagAddAction{
    
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"] withImage:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]];
        [self.randomTag removeObjectAtIndex:index];
    }    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)tagDidRemoveTag:(AOTag *)tag{
    
}

- (void)tagDidSelectTag:(AOTag *)tag{
    OtherTrailController *otherTrailVc = [OtherTrailController new];
    otherTrailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:otherTrailVc animated:YES];
}

- (void)tagUpdateFrame:(float)frameY{
    
    _remindLabel.frame = CGRectMake(20, frameY + 10, 300, 15);
}

- (NSUInteger)getRandomTagIndex
{
    return arc4random() % [self.randomTag count];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"位置黑名单"];
}

@end
