//
//  BaseDao.m
//  Core
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BaseDao.h"
#import "FMDatabase.h"
#import "SharedDaBase.h"
#import "FMDatabaseAdditions.h"

@implementation BaseDao
@synthesize db;

- (id)init {
  if (self = [super init]) {
    // 由 AppDelegate 取得打开的数据库
    db = [[SharedDaBase sharedDataBase] db];
  }
  return self;
}

// SELECT
- (NSDictionary *)getSingle:(NSString *)aSql {
  FMResultSet *rs = [db executeQuery:aSql];
  [rs next];
  NSDictionary *resultDictionary = rs.resultDictionary;
  [rs close];
  return resultDictionary;
}

// SELECT
- (NSMutableArray *)getList:(NSString *)aSql {

  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
  FMResultSet *rs = [db executeQuery:aSql];
  while ([rs next]) {
    id tr = [rs resultDictionary];
    if (nil == tr) {
      [rs close];
      return nil;
    }
    [result addObject:tr];
  }
  [rs close];
  return result;
}

- (void)insertWithTable:(NSString *)tableName Dictionary:(NSDictionary *)aDic {
  if ([aDic count] <= 0) {
    return;
  }
  NSMutableString *sql =
      [[NSMutableString alloc] initWithFormat:@"INSERT INTO %@(", tableName];
  NSMutableString *para = [[NSMutableString alloc] initWithString:@" VALUES ("];
  NSArray *keys = [aDic allKeys];
  for (NSString *str in keys) {
    [sql appendFormat:@"%@,", str];
    [para appendFormat:@":%@,", str];
  }
  [sql replaceCharactersInRange:NSMakeRange([sql length] - 1, 1)
                     withString:@")"];
  [para replaceCharactersInRange:NSMakeRange([para length] - 1, 1)
                      withString:@")"];
  [sql appendString:para];
  [db executeUpdate:sql withParameterDictionary:aDic];
  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
  }
}

- (BOOL)deleteWithSql:(NSString *)aSql andDictionary:(NSDictionary *)aDic {
  BOOL success = YES;
  if (aDic) {
    [db executeUpdate:aSql withParameterDictionary:aDic];
  } else {
    [db executeUpdate:aSql];
  }

  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    success = NO;
  }
  return success;
}
- (BOOL)updateWithSql:(NSString *)aSql andArray:(NSArray *)aArray {
  BOOL success = YES;
  [db executeUpdate:aSql withArgumentsInArray:aArray];
  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    success = NO;
  }
  return success;
}
@end
