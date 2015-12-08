//
//  ContentView.m
//  SegmentBarProject
//
//  Created by liaowei on 15/8/14.
//  Copyright (c) 2015年 liaowei. All rights reserved.
//

#import "ContentView.h"

@interface ContentView()<UITableViewDataSource, UITableViewDelegate>
/** 显示的tableview **/
@property(nonatomic, strong) UITableView *tableView;
/** 数据源 **/
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation ContentView

- (id)initWithFrame:(CGRect)frame andControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        self.frame = frame;
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces =YES;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_tableView];
        _dataSource = controllers;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"viewCell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        UIViewController *vc = [_dataSource objectAtIndex:indexPath.row];
        vc.view.frame = cell.bounds;
        [cell.contentView addSubview:vc.view];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    if (self.swipeDelegate != nil && [self.swipeDelegate respondsToSelector:@selector(contentSelectedSegmentIndexChanged:)]) {
        int index = _tableView.contentOffset.y / self.frame.size.width;
        [self.swipeDelegate contentSelectedSegmentIndexChanged:index];
    }
}

- (void)setCurrentTableViewIndex:(int)index {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}



@end
