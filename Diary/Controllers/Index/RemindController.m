//
//  RemindController.m
//  Diary
//
//  Created by 我 on 15/12/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "RemindController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "CarouseCell.h"
#import "WonderfulCell.h"
#import "AlbumHeadCell.h"
#import "AlbumEnjoyCell.h"

@interface RemindController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation RemindController{
    
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
    switch (indexPath.row) {
        case 0:
            
            return 124 * (Screen_Width / 320);
            break;
        case 1:
            
            return 150;
            break;
        case 2:
            
            return 40;
            break;
            
        default:
            
            return 210;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            static NSString* carouseCellid = @"carouseCellid";
            CarouseCell * carouseCell = [tableView dequeueReusableCellWithIdentifier:carouseCellid];
            if (!carouseCell) {
                carouseCell =
                [[CarouseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:carouseCellid];
                carouseCell.backgroundColor = BGViewColor;
                carouseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return carouseCell;
        }
            
            break;
            
        case 1:{
            
            static NSString* wonderfulCellid = @"wonderfulCellid";
            WonderfulCell * wonderfulCell = [tableView dequeueReusableCellWithIdentifier:wonderfulCellid];
            if (!wonderfulCell) {
                wonderfulCell =
                [[WonderfulCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:wonderfulCellid];
                wonderfulCell.backgroundColor = BGViewColor;
                wonderfulCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return wonderfulCell;
        }
            
            break;
            
        case 2:{
            
            static NSString* albumHeadCellid = @"albumHeadCellid";
            AlbumHeadCell * albumHeadCell = [tableView dequeueReusableCellWithIdentifier:albumHeadCellid];
            if (!albumHeadCell) {
                albumHeadCell =
                [[AlbumHeadCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:albumHeadCellid];
                albumHeadCell.backgroundColor = BGViewColor;
                albumHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return albumHeadCell;
        }
            
            break;
            
        default:{
            
            static NSString* albumEnjoyCellid = @"albumEnjoyCellid";
            AlbumEnjoyCell * albumEnjoyCell = [tableView dequeueReusableCellWithIdentifier:albumEnjoyCellid];
            if (!albumEnjoyCell) {
                albumEnjoyCell =
                [[AlbumEnjoyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:albumEnjoyCellid];
                albumEnjoyCell.backgroundColor = BGViewColor;
                albumEnjoyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return albumEnjoyCell;
        }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
