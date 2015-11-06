//
//  TravelTable.m
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TravelTable.h"

@implementation TravelTable

#pragma mark - CTPersistanceTableProtocol
- (NSString *)databaseName
{
    return @"Diary.sqlite";
}

- (NSString *)tableName
{
    return @"Travel";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"travelID":@"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"uuid":@"Varchar",
             @"travelName":@"Varchar",
             @"travelDesc":@"Varchar",
             @"travelLogo":@"Varchar"
             };
}

- (NSString *)primaryKeyName
{
    return @"travelID";
}

@end
