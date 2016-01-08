//
//  NotifationController.m
//  Diary
//
//  Created by 我 on 15/11/19.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "NotifationController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "DHSwipableCell.h"
#import "BaseNavigation.h"

 static NSString* const dHSwipableCellid = @"dHSwipableCellid";
@interface NotifationController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,DHSwipableCellDelegate>

@end

@implementation NotifationController{
    
    UITableView* _tableView;
    NSIndexPath * _lastSelectCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - NavigationBarHeight )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[DHSwipableCell class] forCellReuseIdentifier:dHSwipableCellid];
    [self.view addSubview:_tableView];
}

#pragma mark - protocol
- (NSInteger)numberOfItemsInCell:(DHSwipableCell *)cell
{

    return 2;
}

- (id)swipableCell:(DHSwipableCell *)cell contentForItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"消息免打扰";
            break;
            
        default:
            return @"删除";
            break;
    }
  
}

- (UIColor *)swipableCell:(DHSwipableCell *)cell colorForItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            
            return COLOR_GRAY_DEFAULT_180;
            break;
            
        default:
            
            return [UIColor redColor];
            break;
    }
}

- (CGFloat)swipableCell:(DHSwipableCell *)cell widthForItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return 120;
            break;
            
        default:
            return 80;
            break;
    }
    
}

- (void)swipableCell:(DHSwipableCell *)cell didClickOnItemAtIndex:(NSInteger)index
{
 
}

- (void)didBeginEditingCell:(DHSwipableCell *)cell
{
    if (_lastSelectCell != cell.indexPath) {
        DHSwipableCell *lastCell = [_tableView cellForRowAtIndexPath:_lastSelectCell];
        [lastCell close];
    }
    _lastSelectCell = cell.indexPath;
}

- (void)didEndEditingCell:(DHSwipableCell *)cell
{
    
}

#pragma mark - table view protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.5;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DHSwipableCell * dHSwipableCell = [tableView dequeueReusableCellWithIdentifier:dHSwipableCellid forIndexPath:indexPath];
    dHSwipableCell.delegate = self;
    dHSwipableCell.indexPath = indexPath;
    
    return dHSwipableCell;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"系统通知"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
