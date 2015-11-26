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
#import "Masonry.h"
#import "EGOImageView.h"
#import "IdentifyDetailController.h"
#import "ARSegmentPageController.h"
#import "UIImage+ImageEffects.h"
#import "TextView.h"

@interface IdentifyController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,ARSegmentControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)EGOImageView *headImg;
@property (nonatomic,strong)UILabel * addressLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic, strong) ARSegmentPageController *pager;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIImage *blurImage;

@end

@implementation IdentifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initSegment];
}

- (void)initView{
    self.view.backgroundColor = BGViewColor;
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH,SCREEN_HEIGHT )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
//    [self.view addSubview:self.headImg];
//    [self.view addSubview:self.grayLabel];
//    [self.view addSubview:self.addressLabel];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)initSegment{
    
    self.defaultImage = [UIImage imageNamed:@"pic_bg"];
    self.blurImage = [UIImage imageNamed:@"pic_bg"];
    IdentifyDetailController *identifyDetailVc = [IdentifyDetailController new];
    ARSegmentPageController *pager = [[ARSegmentPageController alloc]init];
    [pager setViewControllers:@[identifyDetailVc]];
    pager.segmentMiniTopInset = 64;
    self.pager = pager;
    [self.pager addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:NULL];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(onleftItem:)];
    self.pager.navigationItem.rightBarButtonItem = rightItem;
    self.pager.hidesBottomBarWhenPushed = YES;
    TextView *textView = [[TextView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [self.pager.view addSubview:textView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    switch (indexPath.row) {
        case 0:{
            
            static NSString *IdentifyHeadIdentifier = @"IdentifyHeadIdentifier";
            IdentifyHeadCell *identifyHeadCell = [tableView dequeueReusableCellWithIdentifier:IdentifyHeadIdentifier];
            if (!identifyHeadCell) {
                identifyHeadCell = [[IdentifyHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifyHeadIdentifier];
                identifyHeadCell.backgroundColor = BGViewColor;
                identifyHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return identifyHeadCell;
        }
            break;
            
        default:{
            
            static NSString *identifyIdentifier = @"identifyIdentifier";
            IdentifyCell *identifyCell = [tableView dequeueReusableCellWithIdentifier:identifyIdentifier];
            if (!identifyCell) {
                identifyCell = [[IdentifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyIdentifier];
                identifyCell.backgroundColor = BGViewColor;
                identifyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return identifyCell;
        }
            break;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            return 40.5;
            break;
            
        default:
            
            return 90.5;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.navigationController pushViewController:self.pager animated:YES];
}

#pragma mark -- DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"暂无内容哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

#pragma mark -- ARSegmentControllerDelegate
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGFloat topInset = [change[NSKeyValueChangeNewKey] floatValue];
    
    if (topInset <= self.pager.segmentMiniTopInset) {
        
        self.pager.headerView.imageView.image = self.blurImage;
    }else{
        
        self.pager.headerView.imageView.image = self.defaultImage;
    }
}

-(NSString *)segmentTitle
{
    return nil;
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}

#pragma mark -- UIBarButtonItem Action
- (void)onleftItem:(UIBarButtonItem *)sender{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIView *superView = self.view;
    
//    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left);
//        make.top.mas_equalTo(superView.mas_top);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(@400);
//    }];
//    
//    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left).offset(20);
//        make.top.mas_equalTo(_headImg.mas_bottom);
//        make.width.mas_equalTo(@120);
//        make.height.mas_equalTo(@40);
//    }];
//    
//    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left);
//        make.top.mas_equalTo(_addressLabel.mas_bottom);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(@0.5);
//    }];
//    
//    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_headImg.mas_left).offset(15);
//        make.top.mas_equalTo(_headImg.mas_top).offset(30);
//        make.width.height.mas_equalTo(@22);
//    }];
//    
//    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_headImg.mas_right).offset(-10);
//        make.top.mas_equalTo(_headImg.mas_top).offset(40);
//        make.width.mas_equalTo(@60);
//        make.height.mas_equalTo(@15);
//    }];

}
//
//- (EGOImageView *)headImg{
//    if (_headImg == nil) {
//        _headImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
//        _headImg.userInteractionEnabled = YES;
//        [_headImg addSubview:self.nextBtn];
//        [_headImg addSubview:self.backBtn];
//    }
//    return _headImg;
//}
//
//- (UIButton *)nextBtn{
//    if (_nextBtn == nil) {
//        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];\
//        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//        _nextBtn.titleLabel.font = FONT_SIZE_15;
//        [_nextBtn setTitleColor:BGViewColor forState:UIControlStateNormal];
//        _nextBtn.tag = 101;
//        [_nextBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _nextBtn;
//}
//
//- (UIButton *)backBtn{
//    if (_backBtn == nil) {
//        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_backBtn setImage:[UIImage imageNamed:@"ic_return@3x"] forState:UIControlStateNormal];
//        [_backBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _backBtn.tag = 100;
//    }
//    return _backBtn;
//}
//
//- (UILabel *)grayLabel{
//    if (_grayLabel == nil) {
//        _grayLabel = [UILabel new];
//        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_185;
//    }
//    return _grayLabel;
//}
//
//- (UILabel *)addressLabel{
//    if (_addressLabel == nil) {
//        _addressLabel = [UILabel new];
//        _addressLabel.text = @"请选择当前位置";
//        _addressLabel.font = FONT_SIZE_15;
//    }
//    return _addressLabel;
//}
//
//#define mark -- UIButton Action
//- (void)onBackBtn:(UIButton *)sender{
//    switch (sender.tag) {
//        case 100:
//            [self.navigationController popViewControllerAnimated:YES];
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
