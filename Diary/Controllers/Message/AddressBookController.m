//
//  AdressController.m
//  Diary
//
//  Created by 我 on 15/11/19.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AddressBookController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "FriendCell.h"
#import "AddFriendController.h"

@interface AddressBookController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UISearchBarDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UISearchBar* searchBar; //搜索框

@end

@implementation AddressBookController{
    
    UIBarButtonItem *_rightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    [self initView];
}

- (void)initView{
    
    _rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_share@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightItem;
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight)];
    [_searchBar setBackgroundColor:COLOR_GRAY_LIGHT];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.barTintColor = TableSeparatorColor;
    [_searchBar.layer setBorderWidth:1];
    [_searchBar.layer setBorderColor:TableSeparatorColor.CGColor];
    
    _tableView.tableHeaderView = _searchBar; //把搜索框放在表头
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *friendIdentifier = @"friendIdentifier";
    FriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:friendIdentifier];
    if (!friendCell) {
        friendCell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:friendIdentifier];
        friendCell.backgroundColor = BGViewColor;
        friendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return friendCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.5;
}

#pragma mark -- DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"暂无内容哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{

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

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    AddFriendController *friendVc = [AddFriendController new];
    friendVc.hidesBottomBarWhenPushed = YES;
    friendVc.mapView = self.mapView;
    [self.navigationController pushViewController:friendVc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
