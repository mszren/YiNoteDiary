//
//  Category.m
//  Diary
//
//  Created by 我 on 15/12/16.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "UIColor+NavigationBar.h"
#import "UIImage+Utils.h"

@implementation UIColor(NavigationBar)

//改变导航栏状态
+ (void)changeNacigationBarStatus:(CGFloat)offset andController:(UIViewController *)controller{
    
    // 往上拖动，高度减少。
    CGFloat height = CoolNavHeight - offset;
    
    if (height < NavigationBarHeight) {
        height = NavigationBarHeight;
    }
    
//    _headHCons.constant = height;
    
    // 设置导航条的背景图片
    CGFloat alpha = offset / (CoolNavHeight - NavigationBarHeight);
    
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    // 设置导航条的背景图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:135/255.0 green:231/255.0        blue:27/255.0 alpha:alpha]];
    
    [controller.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    controller.navigationController.navigationBar.alpha = alpha;
}

@end
