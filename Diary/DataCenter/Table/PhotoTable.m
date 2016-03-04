//
//  PhotoTable.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "PhotoTable.h"
#import "PhotoRecord.h"

@implementation PhotoTable
#pragma mark - CTPersistanceTableProtocol
- (NSString *)databaseName
{
    return @"Diary.sqlite";
}

- (NSString *)tableName
{
    return @"Photo";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"photoID":@"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"travelID":@"INTEGER",
             @"photoDesc":@"Varchar",
             @"photoURL":@"Varchar",
             @"travelLogo":@"Varchar",
             @"latitude":@"real",
             @"longitude":@"real",
             @"createTime":@"real",
             @"photoImgPath":@"Varchar",
            
             };
}

- (Class)recordClass{
    
    return [PhotoRecord class];
}

- (NSString *)primaryKeyName
{
    return @"photoID";
}

@end
