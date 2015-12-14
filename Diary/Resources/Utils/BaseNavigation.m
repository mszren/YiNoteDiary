//
//  BaseNavigation.m
//  Diary
//
//  Created by 我 on 15/12/14.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "BaseNavigation.h"

@interface BaseNavigation ()

@end

@implementation BaseNavigation

+ (void)setGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titileStr{
    
//     _viewController = controller;
    [controller.navigationController.navigationBar setBarTintColor:BGViewGreen];
     controller.navigationController.navigationBar.alpha = 1.0;
    [controller.navigationController.navigationBar setTranslucent:NO];
    [controller.navigationController.navigationBar setTintColor:BGViewColor];
    
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, 44)];
    titleLab.textColor = BGViewColor;
    titleLab.font = BOLDFont_SIZE_19;
    titleLab.text = titileStr;
    titleLab.textAlignment = NSTextAlignmentCenter;
    controller.navigationItem.titleView = titleLab;
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_browse@3x"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(leftItemAction:)];
    leftItem.title = nil;
    controller.navigationController.navigationItem.leftBarButtonItem = leftItem;
}

+ (void)setGreenNavigationBar:(UIViewController *)controller{
    
    [controller.navigationController.navigationBar setBarTintColor:BGViewGreen];
    controller.navigationController.navigationBar.alpha = 1.0;
    [controller.navigationController.navigationBar setTranslucent:NO];
    [controller.navigationController.navigationBar setTintColor:BGViewColor];
}

#pragma mark -- UIBarButtonItem Action
- (void)leftItemAction:(UIBarButtonItem *)sender{
    
//    [controller.navigationController popViewControllerAnimated:YES];
}

@end
