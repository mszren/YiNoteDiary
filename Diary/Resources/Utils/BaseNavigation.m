//
//  BaseNavigation.m
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "BaseNavigation.h"

@implementation BaseNavigation

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

//下级页面
- (void)setGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titileStr{
    self.viewController = controller;
    [controller.navigationController.navigationBar setBarTintColor:BGViewGreen];
    controller.navigationController.navigationBar.alpha = 1.0;
    [controller.navigationController.navigationBar setTranslucent:NO];
    [controller.navigationController.navigationBar setTintColor:BGViewColor];
    
    //去除导航栏描边黑线
    [controller.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [controller.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    if (titileStr != nil) {
        
        UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, 44)];
        titleLab.textColor = BGViewColor;
        titleLab.font = BOLDFont_SIZE_19;
        titleLab.text = titileStr;
        titleLab.textAlignment = NSTextAlignmentCenter;
        controller.navigationItem.titleView = titleLab;
    }
    
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_return"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(leftItemAction:)];
    controller.navigationItem.leftBarButtonItem = leftItem;
}

//主模块
- (void)setIndexGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titleStr{
    
    [controller.navigationController.navigationBar setBarTintColor:BGViewGreen];
    controller.navigationController.navigationBar.alpha = 1.0;
    [controller.navigationController.navigationBar setTranslucent:NO];
    [controller.navigationController.navigationBar setTintColor:BGViewColor];
    
    
     //去除导航栏描边黑线
    [controller.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [controller.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    if (titleStr != nil) {
        
        UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, 44)];
        titleLab.textColor = BGViewColor;
        titleLab.font = BOLDFont_SIZE_19;
        titleLab.text = titleStr;
        titleLab.textAlignment = NSTextAlignmentCenter;
        controller.navigationItem.titleView = titleLab;
    }
}

#pragma mark -- UIBarButtonItem Action
- (void)leftItemAction:(UIBarButtonItem *)sender{
    
   [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
