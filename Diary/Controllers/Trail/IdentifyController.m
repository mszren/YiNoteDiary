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
#import "NavagationBarView.h"

@interface IdentifyController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,BaseNavigationDelegate,EGOTableViewDelegate,NavagationBarViewDelegate>
@property (nonatomic,strong) EGOImageView *featureImgView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (strong, nonatomic) NSLayoutConstraint *headHCons;
@property (nonatomic,strong) UIView *featureView;
@property (nonatomic,strong) NavagationBarView *barView;

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
    
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
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

    _featureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CoolNavHeight)];
    
    _featureImgView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed: @"pic_bg"]];
    _featureImgView.frame = CGRectMake(0, 0, Screen_Width, CoolNavHeight);
    _featureImgView.contentMode = UIViewContentModeScaleAspectFill;
    _featureImgView.clipsToBounds = YES;
    _tableView.tableHeaderView = _featureView;
    [_featureView addSubview:_featureImgView];
    
    _barView = [[NavagationBarView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, NavigationBarHeight)];
    _barView.delegate = self;
    [self.view addSubview:_barView];

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
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        
        CGRect rect = self.featureView.frame;
        rect.size.height = CoolNavHeight - offsetY;
        rect.origin.y = offsetY;
        _featureImgView.frame = rect;
        _featureView.clipsToBounds = NO;
    }
    
    [_barView changeNacigationBarStatus:offsetY];
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

- (void)navagationBarViewBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE

@end
