//
//  Track.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TrackTable.h"

@implementation TrackTable
#pragma mark - CTPersistanceTableProtocol
- (NSString *)databaseName
{
    return @"Diary.sqlite";
}

- (NSString *)tableName
{
    return @"Track";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"trackID":@"INTEGER PRIMARY KEY AUTOINCREMENT",
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
