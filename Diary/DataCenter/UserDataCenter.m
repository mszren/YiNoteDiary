//
//  UserDataCenter.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "UserDataCenter.h"

@implementation UserDataCenter

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t UserDataCenterOnceToken;
    static UserDataCenter *sharedInstance = nil;
    dispatch_once(&UserDataCenterOnceToken, ^{
        sharedInstance = [[UserDataCenter alloc] init];
    });
    return sharedInstance;
}

-(void)saveUser:(NSDictionary*) user{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentuser.plist"];
    //输入写入
    [user writeToFile:filename atomically:YES];
}

-(NSDictionary*)loadUser{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentuser.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    return data;
}

@end
