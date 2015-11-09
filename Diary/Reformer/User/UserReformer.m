//
//  UserReformer.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "UserReformer.h"

@implementation UserReformer

 NSString *const kUserID=@"id";
 NSString *const kUserName=@"username";
 NSString *const kUserNickName=@"nickname";
 NSString *const kUserAuthKey=@"auth_key";
 NSString *const kUserEMail=@"email";
 NSString *const kUserWeiboUseID=@"weibo_usid";
 NSString *const kUserStatus=@"status";


- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    return @{
             @"id" : data[kUserID] != [NSNull null]
             ? data[kUserID]
             : @"",
             @"username" : data[kUserName] != [NSNull null]
             ? data[kUserName]
             : @"",
             @"nickname" : data[kUserNickName] != [NSNull null]
             ? data[kUserNickName]
             : @"",
             @"auth_key" : data[kUserAuthKey] != [NSNull null]
             ? data[kUserAuthKey]
             : @"",
             @"email" : data[kUserEMail] != [NSNull null]
             ? data[kUserEMail]
             : @"",
             @"weibo_usid" : data[kUserWeiboUseID] != [NSNull null]
             ? data[kUserWeiboUseID]
             : @""
             };
}

@end
