//
//  FeatureDetailController.m
//  Diary
//
//  Created by 我 on 15/11/16.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FeatureDetailController.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "FeatureDetailHeadCell.h"
#import "FeatureCommentCell.h"
#import "CoolNavi.h"

@interface FeatureDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) CoolNavi *headerView;
@property (nonatomic, strong) UIImageView *returnImg;

@end

@implementation FeatureDetailController

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
    _tableView.backgroundColor = BGViewColor;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView registerClass:[FeatureDetailHeadCell class] forCellReuseIdentifier:FeatureDetailHeadCellIdentifier];
    
    [_tableView registerClass:[FeatureCommentCell class] forCellReuseIdentifier:FeatureCommentCellIdentifier];
    
    
    [_tableView setBackgroundColor:AllTableViewColor];
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
    

}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
           
                return [_tableView fd_heightForCellWithIdentifier:FeatureDetailHeadCellIdentifier cacheByIndexPath:indexPath configuration:nil];
            break;
            
        default:
            
                return [_tableView fd_heightForCellWithIdentifier:FeatureCommentCellIdentifier cacheByIndexPath:indexPath configuration:nil];
            break;
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            

            FeatureDetailHeadCell *featureDetailHeadCell = [tableView dequeueReusableCellWithIdentifier:FeatureDetailHeadCellIdentifier forIndexPath:indexPath];
            return featureDetailHeadCell;
        }
            
            break;
            
        default:{
            

            FeatureCommentCell *featureCommentCell = [tableView dequeueReusableCellWithIdentifier:FeatureCommentCellIdentifier forIndexPath:indexPath];
            return featureCommentCell;
        }
            break;
    }

    
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有详情哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_153};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
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
