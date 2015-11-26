//
//  IdentifyDetailController.m
//  Diary
//
//  Created by 我 on 15/11/18.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyDetailController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "IdentifyDetailCell.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "IdentifyEditView.h"

@interface IdentifyDetailController () <UITextFieldDelegate,IdentifyEditViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)EGOImageView *headImg;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UILabel *destinationLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *locationLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UILabel *editLabel;
@property (nonatomic,strong)UIView *editView;

@end

@implementation IdentifyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = BGViewColor;
//    [self.view addSubview:self.headImg];
//    [self.view addSubview:self.titleLabel];
//    [self.view addSubview:self.destinationLabel];
//    [self.view addSubview:self.locationLabel];
//    [self.view addSubview:self.grayLabel];
//    [self.view addSubview:self.editView];
//    [self.view addSubview:self.editLabel];
    [self initView];
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifyDetailIdentifier = @"identifyDetailIdentifier";
    IdentifyDetailCell *identifyDetailCell = [tableView dequeueReusableCellWithIdentifier:identifyDetailIdentifier];
    if (!identifyDetailCell) {
        identifyDetailCell = [[IdentifyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyDetailIdentifier];
        identifyDetailCell.backgroundColor = BGViewColor;
        identifyDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return identifyDetailCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.5;
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

#pragma mrak -- ARSegmentControllerDelegate
-(NSString *)segmentTitle
{
    return nil;
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
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
//    
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left).offset(10);
//        make.top.mas_equalTo(_headImg.mas_bottom).offset(10);
//        make.width.mas_equalTo(@100);
//        make.height.mas_equalTo(@15);
//    }];
//
//    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(superView.mas_right).offset(-10);
//        make.top.mas_equalTo(_headImg.mas_bottom).offset(10);
//        make.width.mas_equalTo(@120);
//        make.height.mas_equalTo(@15);
//    }];
//    
//    [_destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_titleLabel.mas_left);
//        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
//        make.width.mas_equalTo(@(SCREEN_WIDTH - 55));
//        make.height.mas_equalTo(40);
//    }];
//    
//    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left);
//        make.top.mas_equalTo(_destinationLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(@0.5);
//    }];
//    
//    [_editView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(superView.mas_left);
//        make.bottom.mas_equalTo(superView.mas_bottom);
//        make.width.mas_equalTo(@(SCREEN_WIDTH));
//        make.height.mas_equalTo(@40);
//    }];
//    
//    [_editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_editView.mas_left).offset(5);
//        make.top.mas_equalTo(_editView.mas_top).offset(5);
//        make.width.mas_equalTo(@(SCREEN_WIDTH - 10));
//        make.height.mas_equalTo(@30);
//    }];
//    
}

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
//        [_nextBtn setTitle:@"发布" forState:UIControlStateNormal];
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
//- (UILabel *)titleLabel{
//    if (_titleLabel == nil) {
//        _titleLabel = [UILabel new];
//        _titleLabel.text = @"国际购物中心";
//        _titleLabel.font = FONT_SIZE_15;
//    }
//    return _titleLabel;
//}
//
//- (UILabel *)locationLabel{
//    if (_locationLabel == nil) {
//        _locationLabel = [UILabel new];
//        _locationLabel.text = @"31.19243,121.54044";
//        _locationLabel.font = FONT_SIZE_13;
//        _locationLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return _locationLabel;
//}
//
//- (UILabel *)destinationLabel{
//    if (_destinationLabel == nil) {
//        _destinationLabel = [UILabel new];
//        _destinationLabel.numberOfLines = 0;
//        _destinationLabel.text = @"北京市朝阳区工人体育场北路购物服务商城;购物中心";
//        _destinationLabel.font = FONT_SIZE_13;
//        _destinationLabel.textColor = COLOR_GRAY_DEFAULT_153;
//    }
//    return _destinationLabel;
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
//- (UIView *)editView{
//    
//    if (_editView == nil) {
//        _editView = [UIView new];
//        _editView.backgroundColor = COLOR_GRAY_DEFAULT_185;
//    }
//    return _editView;
//}
//
//- (UILabel *)editLabel{
//    
//    if (_editLabel == nil) {
//        _editLabel = [UILabel new];
//        _editLabel.text = @"   编辑描述";
//        _editLabel.textColor = COLOR_GRAY_DEFAULT_153;
//        _editLabel.backgroundColor = BGViewColor;
//        _editLabel.font = FONT_SIZE_13;
//        _editLabel.layer.cornerRadius = 16;
//        _editLabel.clipsToBounds = YES;
//        _editLabel.layer.shouldRasterize = YES;
//        UITapGestureRecognizer *editTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onEditTap:)];
//        _editLabel.userInteractionEnabled = YES;
//        [_editLabel addGestureRecognizer:editTap];
//    }
//    return _editLabel;
//}
//
//#pragma mark -- UITapGestureRecognizer Action
//- (void)onEditTap:(UITapGestureRecognizer *)sender{
//    
//    [[IdentifyEditView sharedInstance] showIdentifyEditView:_destinationLabel.text andDelegate:self];
//}
//
//#pragma mark -- IdentifyEditViewDelegate
//- (void)identifyEditViewEdit:(NSString *)content{
//    _editLabel.text = content;
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
