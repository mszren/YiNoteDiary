//
//  AppDelegate.h
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UIWindow *loginWindow;
@property(strong, nonatomic) MainController *mainController;
+ (AppDelegate *)shareDelegate;
- (void)loadHomeController;
@end

