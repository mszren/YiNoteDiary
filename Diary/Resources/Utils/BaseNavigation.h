//
//  BaseNavigation.h
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNavigation : NSObject

@property (nonatomic,strong)UIViewController * viewController;

+ (instancetype)sharedInstance;

//主模块
- (void)setIndexGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titleStr;

//下级页面
- (void)setGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titileStr;

@end
