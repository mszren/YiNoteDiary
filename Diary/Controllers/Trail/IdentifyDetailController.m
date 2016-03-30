//
//  IdentifyDetailController.m
//  Diary
//

//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyDetailController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "IdentifyDetailCell.h"
#import "Masonry.h"
#import "IdentifyEditView.h"
#import "UIImage+Utils.h"
#import "EGOImageView.h"
#import "PictureSaveController.h"
#import "MyTrailController.h"
#import "LocationManager.h"
#import "TravelRecord.h"
#import "NavagationBarView.h"

@interface IdentifyDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,IdentifyEditViewDelegate,EGOTableViewDelegate,NavagationBarViewDelegate>
@property (strong, nonatomic) NSLayoutConstraint *headHCons;
@property (nonatomic,strong) EGOImageView *featureImgView;
@property(nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic,strong) UIView *featureView;
@property (nonatomic,strong) NavagationBarView *barView;

@end

@implementation IdentifyDetailController{
    
    EGOTableView* _tableView;
    UIView *_textView;
    UILabel *_textLabel;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self creatTextView];
}

- (void)initView{
    
     
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - 40)
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
    
    _dataList = [[TrailDataCenter shareInstance] loadTravelListData];
}

- (void)creatTextView{
    
    _textView = [UIView new];
    [self.view addSubview:_textView];
    _textView.userInteractionEnabled = YES;
    _textView.backgroundColor = COLOR_GRAY_DEFAULT_240;
    
    _textLabel = [UILabel new];
    _textLabel.text = @"   编辑描述";
    _textLabel.backgroundColor = BGViewColor;
    _textLabel.userInteractionEnabled = YES;
    _textLabel.layer.cornerRadius = 10;
    _textLabel.textColor = COLOR_GRAY_DEFAULT_180;
    _textLabel.font = FONT_SIZE_15;
    _textLabel.clipsToBounds = YES;
    _textLabel.layer.shouldRasterize = YES;
    UITapGestureRecognizer *textTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_textLabel addGestureRecognizer:textTap];
    [_textView addSubview:_textLabel];
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
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 101.5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifyDetailCellid = @"identifyDetailCellid";
    IdentifyDetailCell * identifyDetailCell = [tableView dequeueReusableCellWithIdentifier:identifyDetailCellid];
    if (!identifyDetailCell) {
        identifyDetailCell =
        [[IdentifyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:identifyDetailCellid];
        identifyDetailCell.backgroundColor = BGViewColor;
        identifyDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return identifyDetailCell;
 
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

#pragma mark -- IdentifyEditViewDelegate
- (void)identifyEditView:(NSString *)address{
    
    _textLabel.text = address;
}

#pragma mark -- BaseNavigationDelegate
- (void)baseNavigationDelegateOnRightItemAction{

    TravelRecord * aModel = [[TravelRecord alloc] initWithName:@"北京" logo:@"北京" travelDesc:@"北京__故宫"];
    aModel.createTime = [NSDate currentTime];
    aModel.startLatitude = [LocationManager shareInstance].currentCoord.latitude;
    aModel.startLongitude = [LocationManager shareInstance].currentCoord.longitude;
    
    NSNumber *boolNumber = [NSNumber numberWithBool:NO];
    if ([[TrailDataCenter shareInstance] insertTravelRecord:aModel]) {
        TravelRecord * temp = [[TrailDataCenter shareInstance] selectTravelRecordByuuid:aModel.uuid];
        NSDictionary *dic = @{ACTION_Controller_Name : self,ACTION_Controller_Data : @{CurrentTravelEntity : temp, IsShowMember : boolNumber }};
        [self RouteMessage:ACTION_SHOW_MYTRAIL withContext:dic];
    }
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    
    [[IdentifyEditView sharedInstance] showIdentifyEditView:@"    北京市朝阳区工人体育场北路购物广场服务商城；购物中心" andDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    UIView *superView = self.view;
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.bottom.mas_equalTo(superView.mas_bottom);
        make.width.mas_equalTo(@(Screen_Width));
        make.height.mas_equalTo(@40);
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.top.mas_equalTo(_textView.mas_top).offset(5);
        make.width.mas_equalTo(@(Screen_Width - 20));
        make.height.mas_equalTo(@30);
    }];
}

- (void)navagationBarViewBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE

@end
