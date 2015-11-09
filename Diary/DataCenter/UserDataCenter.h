//
//  UserDataCenter.h
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginController.h"

@interface UserDataCenter : NSObject
+ (instancetype)sharedInstance;

-(void)saveUser:(NSDictionary*) user;
-(NSDictionary*)loadUser;
@end
