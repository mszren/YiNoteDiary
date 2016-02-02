//
//  MyDiaryController.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyDiaryController.h"
#import "BaseNavigation.h"
#import <UIScrollView+EmptyDataSet.h>
#import "MyDiaryHeadCell.h"
#import "MyDiaryFirstCell.h"
#import "MyDiaryCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "EditDiaryController.h"

static NSString * const  myDiaryFirstCellIdentidier = @"MyDiaryFirstCellIdentidier";
static NSString * const  myDiaryCellIdentifier = @"MyDiaryCellIdentifier";
@interface MyDiaryController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,EGOTableViewDelegate>

@end

@implementation MyDiaryController{
    
    UIBarButtonItem* _rightButton;
    EGOTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _tableView = [[EGOTableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - NavigationBarHeight) style:UITableViewStylePlain];
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
    
    [_tableView registerClass:[MyDiaryFirstCell class] forCellReuseIdentifier:myDiaryFirstCellIdentidier];
    
    [_tableView registerClass:[MyDiaryCell class] forCellReuseIdentifier:myDiaryCellIdentifier];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
            static NSString *diaryHeadCellIdentifier = @"diaryHeadCellIdentifier";
            MyDiaryHeadCell *myDiaryHeadCell = [tableView dequeueReusableCellWithIdentifier:diaryHeadCellIdentifier];
            if (!myDiaryHeadCell) {
                myDiaryHeadCell = [[MyDiaryHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:diaryHeadCellIdentifier];
                myDiaryHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myDiaryHeadCell;
        }
            
            break;
            
        case 1:{
            
            static NSString *diaryFirstCellIdentifier = @"diaryFirstCellIdentifier";
            MyDiaryFirstCell *myDiaryFirstCell = [tableView dequeueReusableCellWithIdentifier:diaryFirstCellIdentifier];
            if (!myDiaryFirstCell) {
                myDiaryFirstCell = [[MyDiaryFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:diaryFirstCellIdentifier];
                myDiaryFirstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myDiaryFirstCell;
        }
            
            break;
            
        default:{
            
            static NSString *diaryAlbumCellIdentifier = @"diaryAlbumCellIdentifier";
            MyDiaryCell *myDiaryCell = [tableView dequeueReusableCellWithIdentifier:diaryAlbumCellIdentifier];
            if (!myDiaryCell) {
                myDiaryCell = [[MyDiaryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:diaryAlbumCellIdentifier];
                myDiaryCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myDiaryCell;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 295;
            break;
        case 1:
            
            return [_tableView fd_heightForCellWithIdentifier:myDiaryFirstCellIdentidier configuration:nil];;
            break;
            
        default:
            
            return [_tableView fd_heightForCellWithIdentifier:myDiaryCellIdentifier configuration:nil];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row > 0) {
        EditDiaryController *editDiaryVc = [EditDiaryController new];
        editDiaryVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:editDiaryVc animated:YES];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_tableView tableViewDidEndDragging:scrollView];
}

- (void)onRightItem:(UIBarButtonItem *)sender{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
