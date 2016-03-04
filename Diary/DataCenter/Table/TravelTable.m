//
//  TravelTable.m
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TravelTable.h"
#import "TravelRecord.h"

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
             @"uuid":@"TEXT",
             @"travelName":@"TEXT",
             @"travelDesc":@"TEXT",
             @"travelLogo":@"TEXT",
             @"status":@"INTEGER",
             @"createTime":@"real",
             @"startLatitude":@"real",
             @"startLongitude":@"real"
             };
}

- (Class)recordClass{
    
    return [TravelRecord class];
}

- (NSString *)primaryKeyName
{
    return @"travelID";
}

@end
