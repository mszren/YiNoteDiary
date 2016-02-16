//
//  IdentifyController.m
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "IdentifyCell.h"
#import "IdentifyHeadCell.h"
#import "IdentifyDetailController.h"
#import "BaseNavigation.h"
#import "UIImage+Utils.h"
#import "UIColor+NavigationBar.h"
#import "EGOImageView.h"
#import "TrailController.h"

@interface IdentifyController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,BaseNavigationDelegate,EGOTableViewDelegate>
@property (nonatomic,strong) EGOImageView *featureImgView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (strong, nonatomic) NSLayoutConstraint *headHCons;

@end

@implementation IdentifyController{
    
    EGOTableView* _tableView;
    CGFloat _navalpha;
    UIBarButtonItem *_leftItem;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    _leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_return"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = _leftItem;
    
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, -NavigationBarHeight, Screen_Width,
                                           Screen_height)
                  style:UITableViewStylePlain];
    _tableView.backgroundColor = BGViewColor;
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];

    _featureImgView = [[EGOImageView alloc]initWithPlaceholderImage:_cameraImg];
    _featureImgView.frame = CGRectMake(0, 0, Screen_Width, CoolNavHeight);
    _tableView.tableHeaderView = _featureImgView;

}

#pragma mark -- EGOTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(EGOTableHeaderView*)tableView
{
    
    
}

- (void)pullingTableViewDidStartLoading:(EGOTableView*)tableView
{
    
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    
    return [NSDate date];
}

- (NSDate*)pullingTableViewLoadingFinishedDate
{
    
    return [NSDate date];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 40.5;
            break;
            
        default:
            return 94.5;
            break;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            static NSString* identifyHeadCellid = @"identifyHeadCellid";
            IdentifyHeadCell * identifyHeadCell = [tableView dequeueReusableCellWithIdentifier:identifyHeadCellid];
            if (!identifyHeadCell) {
                identifyHeadCell =
                [[IdentifyHeadCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifyHeadCellid];
                identifyHeadCell.backgroundColor = BGViewColor;
                identifyHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return identifyHeadCell;
        }
            
            break;
            
        default:{
            
            static NSString* identifyCellid = @"identifyCellid";
            IdentifyCell * identifyCell = [tableView dequeueReusableCellWithIdentifier:identifyCellid];
            if (!identifyCell) {
                identifyCell =
                [[IdentifyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifyCellid];
                identifyCell.backgroundColor = BGViewColor;
                identifyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return identifyCell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        IdentifyDetailController *detailVc = [IdentifyDetailController new];
        detailVc.hidesBottomBarWhenPushed = YES;
        detailVc.featureImg = _cameraImg;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tableView tableViewDidScroll:scrollView];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    [UIColor changeNacigationBarStatus:offsetY andController:self];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_tableView tableViewDidEndDragging:scrollView];
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

#pragma mark - BaseNavigationDelegate
- (void)baseNavigationDelegateOnRightItemAction{

    NSDictionary * dic = @{ACTION_Controller_Name : self,ACTION_Controller_Data : _cameraImg};
    [self RouteMessage:ACTION_SHOW_IDENTIFY_DETAIL withContext:dic];
}

#pragma mark - UIBarButtonItem Action
- (void)leftItemAction:(UIBarButtonItem *)sender{

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setCleanNavigationBar:self andRightItemTitle:@"下一步" withDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE

@end
