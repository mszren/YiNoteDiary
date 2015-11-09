//
//  UserBusinessManager.h
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "BusinessBaseManager.h"
#import "LoginController.h"


@interface LoginBusinessManager : BusinessBaseManager

+ (instancetype)sharedInstance;

-(void)login:(LoginController*)loginController;

-(BOOL)isLogin;

-(NSDictionary*)getCurrentUser;

@end
