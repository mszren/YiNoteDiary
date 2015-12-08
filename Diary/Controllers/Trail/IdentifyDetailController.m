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
#import "CoolNavi.h"

@interface IdentifyDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,IdentifyEditViewDelegate>
@property (nonatomic, strong) UIImageView *returnImg;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) CoolNavi *headerView;

@end

@implementation IdentifyDetailController{
    
    UITableView* _tableView;
    UIView *_textView;
    UILabel *_textLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self creatTextView];
}

- (void)initView{
    
     
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, -statusHeight, Screen_Width,
                                           Screen_height + statusHeight)
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _headerView = [[CoolNavi alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CoolNavHeight) backGroudImage:@"pic_bg" ];
    _headerView.scrollView = _tableView;
    [self.view addSubview:_headerView];
    
    _returnImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 33, 22, 22)];
    _returnImg.image = [UIImage imageNamed:@"ic_return"];
    _returnImg.tag = 100;
    _returnImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *returnTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onReturnTap:)];
    [_returnImg addGestureRecognizer:returnTap];
    [self.view addSubview:_returnImg];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(Screen_Width - 80, 30, 70, 25);
    _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(onNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
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

#pragma mark -- UIButton Action
- (void)onNextBtn:(UIButton *)sender{
    
}

#pragma mark -- UITapGestureRecognizer
- (void)onReturnTap:(UITapGestureRecognizer *)sender{
    [_headerView removeObserver];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    
    [[IdentifyEditView sharedInstance] showIdentifyEditView:@"    北京市朝阳区工人体育场北路购物广场服务商城；购物中心" andDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
