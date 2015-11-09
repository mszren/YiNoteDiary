//
//  UserBusinessManager.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "UserBusinessManager.h"
#import "LDNetworking.h"
#import "LoginByPhoneAPIManager.h"
#import "UserDataCenter.h"
#import "ErrorReformer.h"
#import "UserReformer.h"
#import "AppDelegate.h"

@interface UserBusinessManager()<LDAPIManagerApiCallBackDelegate>
@property (nonatomic,copy) UserDataCenter *userDataCenter;
@end

@implementation UserBusinessManager

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t UserBusinessManagerOnceToken;
    static UserBusinessManager *sharedInstance = nil;
    dispatch_once(&UserBusinessManagerOnceToken, ^{
        sharedInstance = [[UserBusinessManager alloc] init];
    });
    return sharedInstance;
}



#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(LDAPIBaseManager *)manager {
    if ([manager isKindOfClass:[LoginByPhoneAPIManager class]]) {
        UserReformer *userReformer=[[UserReformer alloc] init];
        NSDictionary *userDic=[manager fetchDataWithReformer:userReformer];
        [[UserDataCenter sharedInstance] saveUser:userDic];
        [[AppDelegate shareDelegate] loadHomeController];
    }
}

- (void)managerCallAPIDidFailed:(LDAPIBaseManager *)manager {
    
    if ([manager isKindOfClass:[LoginByPhoneAPIManager class]]) {
        ErrorReformer *errorReformer=[[ErrorReformer alloc] init];
        NSDictionary *errorDic=[manager fetchDataWithReformer:errorReformer];
        [ToastManager showToast:[errorDic objectForKey:kErrorMessage] withTime:Toast_Hide_TIME];
    }
}

#pragma mark - public methods

-(void)login:(LoginController*)loginController
{
    LoginByPhoneAPIManager* _loginByPhoneAPIManager = [LoginByPhoneAPIManager sharedInstance];
    _loginByPhoneAPIManager.delegate = self;
    _loginByPhoneAPIManager.paramSource =(id<LDAPIManagerParamSourceDelegate>) loginController;
    [_loginByPhoneAPIManager loadData];
}

-(NSDictionary*)getCurrentUser{
  return  [[UserDataCenter sharedInstance] loadUser];
}

-(BOOL)isLogin{
    NSDictionary *userDic=[self getCurrentUser];
    if (userDic!=nil) {
        return YES;
    }
    return NO;
}

#pragma mark - getters and setters
- (UserDataCenter *)userDataCenter {
    if (_userDataCenter == nil) {
        _userDataCenter = [[UserDataCenter alloc] init];
    }
    return _userDataCenter;
}


@end
