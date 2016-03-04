//
//  LocationTable.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "LocationTable.h"
#import "LocationRecord.h"

@implementation LocationTable
#pragma mark - CTPersistanceTableProtocol
- (NSString *)databaseName
{
    return @"Diary.sqlite";
}

- (NSString *)tableName
{
    return @"location";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"ID":@"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"travelID":@"INTEGER",
             @"latitude":@"real",
             @"longitude":@"real",
             @"createTime":@"real",
             
             };
}

- (Class)recordClass{
    
    return [LocationRecord class];
}

- (NSString *)primaryKeyName
{
    return @"ID";
}

@end
