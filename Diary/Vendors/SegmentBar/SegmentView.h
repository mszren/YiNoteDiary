//
//  SegmentBarView.h
//  SegmentBarProject
//
//  Created by liaowei on 15/8/13.
//  Copyright (c) 2015年 liaowei. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SegmentDelegate <NSObject>

@optional
- (void)contentSelectedSegmentIndexChanged:(int)segmentIndex;
- (void)scrollOffsetChanged:(CGFloat)offset;
- (void)barSegmentIndexChanged:(int)index;

@end

@interface SegmentView : UIScrollView

@property(nonatomic,unsafe_unretained) id<SegmentDelegate>clickDelegate;

/** 初始化函数 **/
- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)captions;

/** 设置SegmentBar当前位置 **/
- (void)setCurrentSegmentBaeIndex:(int)index;

@end
