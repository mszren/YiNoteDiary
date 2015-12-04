//
//  IndexController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IndexController.h"
#import "SegmentBarView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "NearCell.h"
#import "CarouseCell.h"
#import "WonderfulCell.h"
#import "AlbumHeadCell.h"
#import "AlbumEnjoyCell.h"
#import "PublishController.h"
#import "indexRecentDetailController.h"

@interface IndexController() <SegmentBarViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation IndexController{
    
    UITableView* _tableView;
    SegmentBarView* _barView;
    UIBarButtonItem* _rightButton;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _barView = [[SegmentBarView alloc]
                initWithFrame:CGRectMake(0, 0, Screen_Width - 100, 40)
                andItems:@[ @"动态", @"附近", @"推荐" ]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.titleView = _barView;
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - TopBarHeight )
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
    switch (_barView.selectedIndex) {
        case 0:
            
            return 6;
            break;
            
        case 1:
            
            return 3;
            break;
            
        default:
            
            return 6;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (_barView.selectedIndex) {
        case 0:{
            
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
            
            break;
            
        case 1:{
            
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
            
            break;
            
        default:
            
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
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_barView.selectedIndex) {
        case 0:
            
            return 341;
            break;
        case 1:
            
            return 341;
            break;
            
        default:
            
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
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexRecentDetailController *recentDetailVc = [indexRecentDetailController new];
    recentDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recentDetailVc animated:YES];
}

#pragma mark SegmentBarViewDelegate
- (void)barSelectedIndexChanged:(int)newIndex{
    switch (newIndex) {
        case 0:
            self.navigationItem.rightBarButtonItem = _rightButton;
            break;
            
        default:
            
            self.navigationItem.rightBarButtonItem = nil;
            break;
    }
    [_tableView reloadData];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PublishController *publishVc = [PublishController new];
        publishVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:publishVc animated:YES];
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
      [self presentViewController:alertVc animated:YES completion:nil];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
