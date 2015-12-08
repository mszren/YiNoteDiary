//
//  CoolNavi.h
//  Diary
//
//  Created by 我 on 15/12/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolNavi : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
 

- (id)initWithFrame:(CGRect)frame backGroudImage:(NSString *)backImageName ;

- (void)updateSubViewsWithScrollOffset:(CGPoint)newOffset;

- (void)removeObserver;

@end
