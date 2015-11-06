//
//  LoginByPhoneManager.h
//  Diary
//
//  Created by Owen on 15/10/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LDAPIBaseManager.h"

@interface LoginByPhoneManager : LDAPIBaseManager<LDAPIManager,LDAPIManagerValidator,
LDAPIManagerInterceptor>
+ (instancetype)sharedInstance;
@end
