//
//  ActivityController.m
//  Diary
//
//  Created by 我 on 15/12/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ActivityController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "NearCell.h"
#import "indexRecentDetailController.h"

@interface ActivityController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,EGOTableViewDelegate,NearCellDelegate>

@end

@implementation ActivityController{
    
    EGOTableView* _tableView;
    CGFloat _height;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - TabBarHeight - NavigationBarHeight)
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
    
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141 + _height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* nearCellid = @"nearCellid";
    NearCell * nearCell = [tableView dequeueReusableCellWithIdentifier:nearCellid];
    if (!nearCell) {
        nearCell =
        [[NearCell alloc] initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:nearCellid];
        nearCell.backgroundColor = BGViewGray;
        nearCell.selectionStyle = UITableViewCellSelectionStyleNone;
        nearCell.delegate = self;
    }
    [nearCell bindData:indexPath.row];
    
    return nearCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = [NSDictionary
                         dictionaryWithObjectsAndKeys:self, ACTION_Controller_Name, nil];
    [self RouteMessage:ACTION_SHOW_INDEXDETAIL withContext:dic];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_tableView tableViewDidEndDragging:scrollView];
}

- (void)cellHeight:(CGFloat)height{
    _height = height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMPLEMENT_MESSAGE_ROUTABLE

@end
