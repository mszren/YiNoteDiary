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

@interface indexRecentDetailController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,SegmentBarViewDelegate,CommentViewDelegate>

@end

@implementation indexRecentDetailController{
    UITableView *_tableView;
    SegmentBarView* _barView;
    IndexDetailHeadView *_detailHeadView;
    IndexCommentView *_commentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.title = @"详情";
    _detailHeadView = [[IndexDetailHeadView alloc]init];
    _barView = [[SegmentBarView alloc]
                initWithFrame:CGRectMake(0, 0, Screen_Width, 40)
                andItems:@[@"评论",@"赞"]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView setBackgroundColor:AllTableViewColor];
    _tableView.tableHeaderView = _detailHeadView;
    [self.view addSubview:_tableView];
    
    _commentView = [[IndexCommentView alloc]initWithFrame:CGRectMake(0, Screen_height - 40.5, Screen_Width, 40.5)];
    [_commentView.praiseBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView.commentBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView.shareBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentView];
}


#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_barView.selectedIndex) {
        case 0:
            return 93.5;
            break;
            
        default:
            return 66.5;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_barView.selectedIndex) {
        case 0:{
            
            static NSString *commentCellIdentifier = @"commentCellIdentifier";
            CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
            if (!commentCell) {
                commentCell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
                commentCell.backgroundColor  = BGViewColor;
                commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end