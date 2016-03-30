//
//  NavagationBarView.h
//  Diary
//
//  Created by 我 on 16/3/22.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavagationBarViewDelegate <NSObject>

- (void)navagationBarViewBack;

@end

@interface NavagationBarView : UIView
@property (nonatomic,weak)id<NavagationBarViewDelegate>delegate;
@property (nonatomic,strong)UIButton *backBtn;

- (void)changeNacigationBarStatus:(CGFloat)offset;

@end
