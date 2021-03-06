//
//  LoginByPhoneManager.m
//  Diary
//
//  Created by Owen on 15/10/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LoginByPhoneAPIManager.h"

@interface LoginByPhoneAPIManager()
@property(nonatomic, copy, readwrite) NSString *methodName;
@property(nonatomic, strong) NSString *serviceType;
@property(nonatomic, assign) LDAPIManagerRequestType requestType;
@end

@implementation LoginByPhoneAPIManager

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _methodName = @"user/login";
        _serviceType = kLDServiceLightDiary;
        _requestType = LDAPIManagerRequestTypePost;
        self.validator = self;
        self.interceptor = self;
    }
    return self;
}

#pragma mark - LDAPIManagerValidator
- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithCallBackData:(NSDictionary *)data {
    if (data[@"username"] != nil) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)manager:(LDAPIBaseManager *)manager
isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}


#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t LoginByPhoneManagerOnceToken;
    static LoginByPhoneAPIManager *sharedInstance = nil;
    dispatch_once(&LoginByPhoneManagerOnceToken, ^{
        sharedInstance = [[LoginByPhoneAPIManager alloc] init];
    });
    return sharedInstance;
}
@end
