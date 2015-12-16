//
//  BaseNavigation.h
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseNavigationDelegate <NSObject>

//导航栏按钮处理事件的代理
- (void)baseNavigationDelegateOnRightItemAction;

@end

@interface BaseNavigation : NSObject
@property (nonatomic,weak)id<BaseNavigationDelegate>delegate;
@property (nonatomic,strong)UIViewController * viewController;

+ (instancetype)sharedInstance;

//主模块
- (void)setIndexGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titleStr;

//登录模块
- (void)setLoginNavigationBar:(UIViewController *)controller;

//下级页面
- (void)setGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titileStr;

//下级页面(渐变色)
- (void)setCleanNavigationBar:(UIViewController *)controller andRightItemTitle:(NSString *)rightItemTitleStr withDelegate:(id<BaseNavigationDelegate>)delegate;
@end
