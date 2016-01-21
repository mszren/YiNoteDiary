//
//  AdressBookController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AdressBookController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "FriendCell.h"
#import "AddFriendController.h"
#import "BaseNavigation.h"
#import "SPKitExample.h"
#import "SPUtil.h"
#import "AppDelegate.h"
#import "SPContactManager.h"

@interface AdressBookController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UISearchBarDelegate>

@end

@implementation AdressBookController{
    
    UITableView* _tableView;
    UIBarButtonItem* _rightButton;
    UISearchBar* _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - NavigationBarHeight )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, SearchBarHeight)];
    [_searchBar setBackgroundColor:COLOR_GRAY_LIGHT];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.barTintColor = TableSeparatorColor;
    [_searchBar.layer setBorderWidth:1];
    [_searchBar.layer setBorderColor:TableSeparatorColor.CGColor];
    
    _tableView.tableHeaderView = _searchBar; //把搜索框放在表头
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* friendCellid = @"friendCellid";
    FriendCell * friendCell = [tableView dequeueReusableCellWithIdentifier:friendCellid];
    if (!friendCell) {
        friendCell =
        [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault
                          reuseIdentifier:friendCellid];
        friendCell.backgroundColor = BGViewColor;
        friendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return friendCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *personId = [NSString stringWithFormat:@"%@%ld",@"uid",(long)indexPath.row];
    YWPerson *person = [[YWPerson alloc] initWithPersonId:personId appKey:@"23300020"];
    [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
    
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有联系人哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor greenColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

//UISearchBarDelegate协议中定义的方法，当开始编辑时（搜索框成为第一响应者时）被调用。
- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar
{
    _searchBar.showsCancelButton = YES;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"联系人"];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    AddFriendController *addFriendVc = [AddFriendController new];
    addFriendVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFriendVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
