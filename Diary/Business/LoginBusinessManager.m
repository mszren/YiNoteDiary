//
//  UserBusinessManager.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LoginBusinessManager.h"
#import "LDNetworking.h"
#import "LoginByPhoneAPIManager.h"
#import "UserDataCenter.h"

#import "UserReformer.h"

@interface LoginBusinessManager()<LDAPIManagerApiCallBackDelegate>
@property (nonatomic,copy) UserDataCenter *userDataCenter;
@end

@implementation LoginBusinessManager

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t LoginBusinessManagerOnceToken;
    static LoginBusinessManager *sharedInstance = nil;
    dispatch_once(&LoginBusinessManagerOnceToken, ^{
        sharedInstance = [[LoginBusinessManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - LDAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(LDAPIBaseManager *)manager {
    if ([manager isKindOfClass:[LoginByPhoneAPIManager class]]) {
        UserReformer *userReformer=[[UserReformer alloc] init];
        self.virtualRecord=[manager fetchDataWithReformer:userReformer];
        [self.userDataCenter saveUser:self.virtualRecord];
        [self businessCallDidSuccess:self];
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
    self.delegate=(id<BusinessManagerCallBackDelegate>)loginController;
    LoginByPhoneAPIManager* _loginByPhoneAPIManager = [LoginByPhoneAPIManager sharedInstance];
    _loginByPhoneAPIManager.delegate = self;
    _loginByPhoneAPIManager.paramSource =(id<LDAPIManagerParamSourceDelegate>) loginController;
    [_loginByPhoneAPIManager loadData];
}

-(NSDictionary*)getCurrentUser{
  return  [self.userDataCenter loadUser];
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
        _userDataCenter = [UserDataCenter sharedInstance];
    }
    return _userDataCenter;
}

@end
