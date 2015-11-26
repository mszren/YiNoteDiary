//
//  FriendsListController.m
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FriendsListController.h"
#import "FriendCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "FriendMaterialController.h"

@interface FriendsListController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation FriendsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
    [self initView];
}

- (void)initView{
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendMaterialController *materialVc = [FriendMaterialController new];
    materialVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:materialVc animated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
