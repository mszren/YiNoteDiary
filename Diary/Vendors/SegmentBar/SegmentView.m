//
//  SegmentBarView.m
//  SegmentBarProject
//
//  Created by liaowei on 15/8/13.
//  Copyright (c) 2015年 liaowei. All rights reserved.
//

#import "SegmentView.h"

#define kButtonNormalSize 16
#define kButtonSelectSize 20
#define kButtonTagStart 300

@interface SegmentView() <UIScrollViewDelegate>
/** 每个分段对象 **/
@property(nonatomic, strong) NSMutableArray *segmentArray;
/** 底部横线 **/
@property(nonatomic, strong) UIScrollView *lineView;
/** 当前选择的序号 **/
@property(nonatomic, assign) int currentIndex;
/** 上一次选择的序号 **/
@property(nonatomic, assign) NSInteger lastIndex;

@end

@implementation SegmentView

- (NSMutableArray *)segmentArray {
    if (_segmentArray == nil) {
        _segmentArray = [[NSMutableArray alloc] init];
    }
    return _segmentArray;
}

- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)captions {
    self = [super initWithFrame:frame];
    if (self) {
        int width = frame.size.width/captions.count;
        _currentIndex = 0;
        
        for (int i = 0; i < captions.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
//            btn.titleLabel.font = [UIFont systemFontOfSize:kButtonNormalSize];
            btn.titleLabel.font = BOLDFont_SIZE_19;
            [btn setTitleColor:BGViewColor forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(segmentClickAction:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *caption = [captions objectAtIndex:i];
            [btn setTitle:caption forState:UIControlStateNormal];
            btn.tag = kButtonTagStart + i;
            btn.frame = CGRectMake(0 + width*i, 10, width, 25);
            [self addSubview:btn];
          
            [self.segmentArray addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
                btn.titleLabel.font = [UIFont systemFontOfSize:kButtonSelectSize];
            }
        }
        
        self.contentSize = CGSizeMake(width, 30);
        self.showsHorizontalScrollIndicator = NO;
        
        CGRect rc = [self viewWithTag:_currentIndex + kButtonTagStart].frame;
        _lineView = [[UIScrollView alloc] initWithFrame:CGRectMake(rc.origin.x - 2, self.frame.size.height - 3, rc.size.width+4, 3)];
        _lineView.bounces = NO;
        _lineView.showsHorizontalScrollIndicator = NO;
        _lineView.contentSize = CGSizeMake(width, 3);
        _lineView.backgroundColor = BGViewLightGreen;
        [self addSubview:_lineView];
    }
    return self;
}

- (void)segmentClickAction:(UIButton *)btn {
    UIButton *segBtn = (UIButton *)btn;
    if (_currentIndex != segBtn.tag - kButtonTagStart) {
        [self showSelectSegment:(int)(segBtn.tag - kButtonTagStart)];
    }
}

- (void)showSelectSegment:(int)index {
    if (_currentIndex != index) {
        _lastIndex = _currentIndex;
        _currentIndex = index;
        
        UIButton *currentBtn = [_segmentArray objectAtIndex:_currentIndex];
        UIButton *lastBtn = [_segmentArray objectAtIndex:_lastIndex];
        currentBtn.selected = YES;
//        currentBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonSelectSize];
        currentBtn.titleLabel.font = BOLDFont_SIZE_19;
        lastBtn.selected = NO;
//        lastBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonNormalSize];
        lastBtn.titleLabel.font = BOLDFont_SIZE_19;
        
        CGRect lineRC = [self viewWithTag:currentBtn.tag].frame;
        [UIView animateWithDuration:0.2 animations:^{
             _lineView.frame = CGRectMake(lineRC.origin.x-3, self.frame.size.height - 3, lineRC.size.width + 4, 3);
        }];
        if (lineRC.origin.x - self.contentOffset.x > self.frame.size.width * 2 / 3 ) {
            NSInteger index = _currentIndex;
            if (index + 2 < [_segmentArray count]) {
                index = _currentIndex + 2;
            } else if (index + 1 < [_segmentArray count]) {
                index = _currentIndex + 1;
            }
            CGRect frame = [self viewWithTag:index + kButtonTagStart].frame;
            [self scrollRectToVisible:frame animated:YES];
        } else if (lineRC.origin.x - self.contentOffset.x < self.frame.size.width / 3) {
            NSInteger index = _currentIndex;
            if (_currentIndex - 2 >= 0) {
                index = _currentIndex - 2;
            } else if (_currentIndex - 1 >= 0) {
                index = _currentIndex - 1;
            }
            CGRect frame = [self viewWithTag:index + kButtonTagStart].frame;
            [self scrollRectToVisible:frame animated:YES];
        }
        
        if (self.clickDelegate != nil && [self.clickDelegate respondsToSelector:@selector(barSegmentIndexChanged:)]) {
            [self.clickDelegate barSegmentIndexChanged:_currentIndex];
        }
    }
}

- (void)setCurrentSegmentBaeIndex:(int)index {
    if (_currentIndex != index) {
        [self showSelectSegment:index];
    }
}

@end
