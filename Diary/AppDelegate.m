//
//  AppDelegate.m
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "LocationManager.h"
#import "LoginBusinessManager.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LocationManager *locationManager=[LocationManager shareInstance];
    [[MAMapServices sharedServices] setApiKey:ApiKey];
    [[AMapSearchServices sharedServices]setApiKey:ApiKey];
    [locationManager startLocation];
    if ([self checkIsExistUser]) {
        [self loadHomeController];
    } else {
        [self loadLoginController];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)loadLoginController {
    LoginController *controller = [[LoginController alloc] init];
    UINavigationController *loginNav =
    [[UINavigationController alloc] initWithRootViewController:controller];
    self.loginWindow =
    [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.loginWindow.rootViewController = loginNav;
    [self.loginWindow makeKeyAndVisible];
}

- (BOOL)checkIsExistUser {
    return [[LoginBusinessManager sharedInstance] isLogin];
}

- (void)loadHomeController {
    self.mainController = [[MainController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
}

@end
