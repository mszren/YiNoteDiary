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
#import "CoolNavi.h"

@interface IdentifyController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, strong) UIImageView *returnImg;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) CoolNavi *headerView;

@end

@implementation IdentifyController{
    
    UITableView* _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
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
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(onNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
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
        [self.navigationController pushViewController:detailVc animated:YES];
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

#pragma mark -- UIButton Action
- (void)onNextBtn:(UIButton *)sender{
    
    IdentifyDetailController *detailVc = [IdentifyDetailController new];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark -- UITapGestureRecognizer
- (void)onReturnTap:(UITapGestureRecognizer *)sender{
    [_headerView removeObserver];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
