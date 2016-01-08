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
#import "BaseNavigation.h"
#import "UIImage+Utils.h"
#import "category.h"
#import "EGOImageView.h"

@interface FeatureDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,BaseNavigationDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) EGOImageView *featureImg;

@end

@implementation FeatureDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, -NavigationBarHeight, Screen_Width,
                                           Screen_height)
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setBackgroundColor:AllTableViewColor];
    
    [_tableView registerClass:[FeatureDetailHeadCell class] forCellReuseIdentifier:FeatureDetailHeadCellIdentifier];
    
    [_tableView registerClass:[FeatureCommentCell class] forCellReuseIdentifier:FeatureCommentCellIdentifier];
    
    _featureImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed: @"pic_bg"]];
    _featureImg.frame = CGRectMake(0, 0, Screen_Width, CoolNavHeight);
    _tableView.tableHeaderView = _featureImg;
    [self.view addSubview:_tableView];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    [category changeNacigationBarStatus:offsetY andController:self];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [[BaseNavigation sharedInstance] setCleanNavigationBar:self andRightItemTitle:nil withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
