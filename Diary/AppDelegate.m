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

#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

    [UMSocialData setAppKey:@"558b6e7b67e58e833c006f6d"];
    
    [UMSocialSinaHandler
     openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialWechatHandler setWXAppId:@"wx352e935d3715247a"
                            appSecret:@"d3ff113f047b48506290796d8ff05196"
                                  url:@"http://t.cn/RwFRWYQ"];
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法
    [UMSocialConfig hiddenNotInstallPlatforms:@[
                                                UMShareToQQ,
                                                UMShareToQzone,
                                                UMShareToWechatSession,
                                                UMShareToWechatTimeline
                                                ]];
    
    [[MAMapServices sharedServices] setApiKey:ApiKey];
    [[AMapSearchServices sharedServices]setApiKey:ApiKey];
    LocationManager *locationManager=[LocationManager shareInstance];
    [locationManager startLocation];
//    if ([self checkIsExistUser]) {
        [self loadHomeController];
//    } else {
//        [self loadLoginController];
//    }
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

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
