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

@interface ActivityController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation ActivityController{
    
    UITableView* _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height  )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 341;
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
    }
    
    return nearCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexRecentDetailController *detailVc = [indexRecentDetailController new];
    [self.navigationController pushViewController:detailVc animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
