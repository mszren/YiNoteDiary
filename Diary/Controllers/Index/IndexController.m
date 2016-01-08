//
//  IndexController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IndexController.h"
#import "PublishController.h"
#import "ActivityController.h"
#import "NearController.h"
#import "RemindController.h"
#import "SegmentView.h"
#import "ContentView.h"
#import "BaseNavigation.h"

@interface IndexController() <SegmentDelegate>
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) SegmentView *barView;
@property (nonatomic, strong) ContentView *contentView;

@end

@implementation IndexController{
    
    UITableView* _tableView;
    UIBarButtonItem* _rightButton;
    PublishController *_publishVc;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *captions = @[@"动态", @"附近",@"推荐"];
    _barView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, TabBarWidth, TabBarHeigh) andItems:captions];
    _barView.clickDelegate = self;
    self.navigationItem.titleView = _barView;
    
    ActivityController *activityVc = [ActivityController new];
    [self addChildViewController:activityVc];
    
    NearController *nearVc = [NearController new];
    [self addChildViewController:nearVc];
    
    RemindController *remindVc = [RemindController new];
    [self addChildViewController:remindVc];
    
    NSArray *controllers = @[activityVc,nearVc,remindVc];
    _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) andControllers:controllers];
    _contentView.swipeDelegate = self;
    [self.view addSubview:_contentView];
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
}

//改变按钮状态
- (void)changeRightItem:(int)segmentIndex{
    switch (segmentIndex) {
        case 0:
            self.navigationItem.rightBarButtonItem = _rightButton;
            break;
            
        default:
            self.navigationItem.rightBarButtonItem = nil;
            break;
    }
}

#pragma mark -- SegmentDelegate
- (void)contentSelectedSegmentIndexChanged:(int)segmentIndex {
    _currentIndex = segmentIndex;
    [_barView setCurrentSegmentBaeIndex:segmentIndex];
    [self changeRightItem:_currentIndex];
}

- (void)barSegmentIndexChanged:(int)segmentIndex {
    _currentIndex = segmentIndex;
    [_contentView setCurrentTableViewIndex:segmentIndex];
    [self changeRightItem:_currentIndex];
}


#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _publishVc = [PublishController new];
        _publishVc.hidesBottomBarWhenPushed = YES;
        _publishVc.selectType = 0;
        [self.navigationController pushViewController:_publishVc animated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _publishVc = [PublishController new];
        _publishVc.hidesBottomBarWhenPushed = YES;
        _publishVc.selectType = 1;
        [self.navigationController pushViewController:_publishVc animated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
      [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:nil];
}

@end
