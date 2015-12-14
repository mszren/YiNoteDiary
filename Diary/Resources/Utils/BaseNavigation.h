//
//  BaseNavigation.h
//  Diary
//
//  Created by 我 on 15/12/14.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNavigation : NSObject
@property (nonatomic,strong)UIViewController *viewController;

+ (void)setGreenNavigationBar:(UIViewController *)controller;
+ (void)setGreenNavigationBar:(UIViewController *)controller andTitle:(NSString *)titileStr;
@end
