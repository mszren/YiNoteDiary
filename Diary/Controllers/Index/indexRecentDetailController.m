//
//  indexRecentDetailController.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "indexRecentDetailController.h"
#import "IndexDetailHeadView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "SegmentBarView.h"
#import "CommentCell.h"
#import "PraiseCell.h"
#import "IndexCommentView.h"
#import "CommentView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BaseNavigation.h"

@interface indexRecentDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,SegmentBarViewDelegate,CommentViewDelegate,EGOTableViewDelegate>

@end

@implementation indexRecentDetailController{
    EGOTableView *_tableView;
    SegmentBarView* _barView;
    IndexDetailHeadView *_detailHeadView;
    IndexCommentView *_commentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _detailHeadView = [[IndexDetailHeadView alloc]init];
    _barView = [[SegmentBarView alloc]
                initWithFrame:CGRectMake(0, 0, Screen_Width, 40)
                andItems:@[@"评论",@"赞"]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - 40.5 - NavigationBarHeight )
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
    if (_barView.selectedIndex == 0) {
        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"commentCellIdentifier"];
    }
    
    [_tableView setBackgroundColor:AllTableViewColor];
    _tableView.tableHeaderView = _detailHeadView;
    [self.view addSubview:_tableView];
    
    _commentView = [[IndexCommentView alloc]initWithFrame:CGRectMake(0, Screen_height - NavigationBarHeight - 40.5, Screen_Width, 40.5)];
    [_commentView.praiseBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView.commentBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView.shareBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentView];
    
    [_tableView reloadData];
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

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (_barView.selectedIndex) {
        case 0:
            
            return 5;
            break;
            
        default:
            return 6;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_barView.selectedIndex) {
        case 0:
        {
            
            return [_tableView fd_heightForCellWithIdentifier:@"commentCellIdentifier" cacheByIndexPath:indexPath configuration:nil];
        
        }
            break;
            
        default:
            return 66.5;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_barView.selectedIndex) {
        case 0:{

            CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCellIdentifier" forIndexPath:indexPath];
            return commentCell;
            
        }
            
            break;
    
        default:{
    
            static NSString *praiseCellIdentifier = @"praiseCellIdentifier";
            PraiseCell *praiseCell = [tableView dequeueReusableCellWithIdentifier:praiseCellIdentifier];
            if (!praiseCell) {
                praiseCell = [[PraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:praiseCellIdentifier];
                praiseCell.backgroundColor  = BGViewColor;
                praiseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return praiseCell;
        }
            break;
    }
    

}

- (NSString*)tableView:(UITableView*)tableView
titleForHeaderInSection:(NSInteger)section;
{
    return @"";
}

- (UIView*)tableView:(UITableView*)tableView
viewForHeaderInSection:(NSInteger)section
{
    
    UIView* headerView = nil;
    headerView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 20)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    [headerView addSubview:_barView];
    
    UIView* separatorView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 39, Screen_Width, 1)];
    [separatorView setBackgroundColor:TableSeparatorColor];
    [headerView addSubview:separatorView];
    return headerView;
}

- (CGFloat)tableView:(UITableView*)tableView
estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
 
    NSString *text;
    switch (_barView.selectedIndex) {
        case 0:
            
            text = @"没有评论哦!";
            break;
        default:
            
            text = @"没有动态哦!";
            break;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: COLOR_GRAY_DEFAULT_153};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -- CommentViewDelegate
- (void)commentViewReturn:(NSString *)content{
    
}

#pragma mark SegmentBarViewDelegate
- (void)barSelectedIndexChanged:(int)newIndex
{
        [_tableView reloadData];
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 100:
            
            break;
        case 101:
            
            [[CommentView sharedInstance] showCommentView:self];
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
