//
//  ContentView.h
//  SegmentBarProject
//
//  Created by liaowei on 15/8/14.
//  Copyright (c) 2015年 liaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentView.h"

@interface ContentView : UIView

@property(nonatomic,unsafe_unretained) id<SegmentDelegate>swipeDelegate;

- (id)initWithFrame:(CGRect)frame andControllers:(NSArray *)controllers;

/**  设置当前的tableview **/
- (void)setCurrentTableViewIndex:(int)index;

@end
