//
//  NavagationBarView.m
//  Diary
//
//  Created by 我 on 16/3/22.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "NavagationBarView.h"

@implementation NavagationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backBtn];
        self.alpha = 0;
    }
    return self;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(14, 22, 23, 23);
        [_backBtn setImage:[UIImage imageNamed:@"ic_return@3x"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(onBtnBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)onBtnBack{
    
    [self.delegate navagationBarViewBack];
}

- (void)changeNacigationBarStatus:(CGFloat)offset {
    
    // 设置导航条的背景图片
    CGFloat alpha = offset / (CoolNavHeight - NavigationBarHeight);
    
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        alpha = 1;
    }
    NSLog(@"alpha : %f",alpha);
    
    self.backgroundColor =  [UIColor colorWithRed:alpha*135/255.0 green:231/255.0  blue:alpha*27/255.0 alpha:1];
    self.alpha = alpha;
}

@end
