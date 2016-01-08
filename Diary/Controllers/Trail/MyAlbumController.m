//
//  MyAlbumController.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyAlbumController.h"
#import "BaseNavigation.h"
#import <UIScrollView+EmptyDataSet.h>
#import "MyAlbumCell.h"
#import "MyAlbumFirstCell.h"
#import "MyAlbumHeadCell.h"
#import "MyDiaryController.h"

#define IMG_Width (Screen_Width - 80)/3
@interface MyAlbumController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation MyAlbumController{
    
    UIBarButtonItem* _rightButton;
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - NavigationBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
            static NSString *headCellIdentifier = @"headCellIdentifier";
            MyAlbumHeadCell *myAlbumHeadCell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
            if (!myAlbumHeadCell) {
                myAlbumHeadCell = [[MyAlbumHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellIdentifier];
                myAlbumHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myAlbumHeadCell;
        }
            
            break;
            
        case 1:{
            
            static NSString *firstCellIdentifier = @"firstCellIdentifier";
            MyAlbumFirstCell *myAlbumFirstCell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
            if (!myAlbumFirstCell) {
                myAlbumFirstCell = [[MyAlbumFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
                myAlbumFirstCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myAlbumFirstCell;
        }
            
            break;
            
        default:{
            
            static NSString *albumCellIdentifier = @"albumCellIdentifier";
            MyAlbumCell *myAlbumCell = [tableView dequeueReusableCellWithIdentifier:albumCellIdentifier];
            if (!myAlbumCell) {
                myAlbumCell = [[MyAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:albumCellIdentifier];
                myAlbumCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return myAlbumCell;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 220;
            break;
        case 1:
            
            return 80 + 2*IMG_Width;
            break;
            
        default:
            
            return 60 + 2*IMG_Width;
            break;
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

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    MyDiaryController *myDiaryVc = [MyDiaryController new];
    myDiaryVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myDiaryVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的专辑"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
