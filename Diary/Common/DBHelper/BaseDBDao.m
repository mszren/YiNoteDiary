//
//  BaseDao.m
//  Core
//
//  Created by 曹亮 on 14/11/18.
//  Copyright (c) 2014年 FamilyTree. All rights reserved.
//

#import "BaseDBDao.h"
#import "FMDatabase.h"
#import "SharedDaBase.h"
#import "FMDatabaseAdditions.h"

@implementation BaseDBDao
@synthesize db, tableName, className;

/*
 @method      initWithTableName: ClassName:
 @abstract    实例化对象，参数为表名，对应实体类的类名.
 @result      id
 */
- (id)initWithTableName:(NSString *)aTableName
              ClassName:(NSString *)aClassName {
  if (self = [super init]) {
    // 由 AppDelegate 取得打开的数据库
    db = [[SharedDaBase sharedDataBase] db];
    self.tableName = aTableName;
    self.className = aClassName;
      
      //建表
      NSString *sql = @"create table if not exists travel(travelID integer primary key autoincrement,uuid,travelName,travelLogo,travelDesc,status,createTime,startLatitude,startLongitude);""create table if not exists photo(photoID integer primary key autoincrement,travelID,photoDesc,photoURL,latitude,longitude,createTime);""CREATE TABLE location(ID integer primary key autoincrement,travelID,latitude,longitude,createTime);";
      if (![db executeStatements:sql]) {
          NSLog(@"建表失败:%@",db.lastErrorMessage);
      }else{
          NSLog(@"建表成功");
      }
      
  }
  return self;
}

- (id)init {
  return [self initWithTableName:nil ClassName:nil];
}

- (BOOL)insertWithModel:(id)aModel {
  return NO;
}

- (NSMutableArray *)selectEntityList {
  NSString *newSql =
      [NSString stringWithFormat:@"select * from %@", self.tableName];
  NSMutableArray *resultArr = [self query:newSql];
  return resultArr;
}



// 子类中实现
- (NSString *)setSql:(NSString *)aSql {
  return NULL;
}
// SELECT
- (NSMutableArray *)query:(NSString *)aSql {
  if ([tableName length] <= 0 || [className length] <= 0) {
    NSLog(@"table is  null or className is  null");
    return nil;
  }

  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
  FMResultSet *rs = [db executeQuery:aSql];
  while ([rs next]) {
    id tr = [[NSClassFromString(className) alloc]
        initWithDictionary:[rs resultDictionary]];
    if (nil == tr) {
      [rs close];
      return nil;
    }
    [result addObject:tr];
  }
  [rs close];
  return result;
}

//有参数查询
- (NSMutableArray *)query:(NSString *)aSql andWhere:(NSArray *)aWhere {
  if ([tableName length] <= 0 || [className length] <= 0) {
    NSLog(@"table is  null or className is  null");
    return nil;
  }

  NSMutableArray *result = [[NSMutableArray alloc] init];
  FMResultSet *rs = nil;
  if (aWhere) {
    rs = [db executeQuery:aSql withArgumentsInArray:aWhere];
  } else {
    rs = [db executeQuery:aSql];
  }

  while ([rs next]) {
    id tr = [[NSClassFromString(className) alloc]
        initWithDictionary:[rs resultDictionary]];
    if (nil == tr) {
      [rs close];
      return nil;
    }
    [result addObject:tr];
  }
  [rs close];
  return result;
}
- (BOOL)insertWithDictionary:(NSDictionary *)aDic {
  if ([aDic count] <= 0) {
    return NO;
  }
  BOOL success = YES;
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
    success = NO;
  } else {
    success = YES;
  }
  return success;
}

- (void)insertWithArray:(NSArray *)aArray {
  for (NSDictionary *dic in aArray) {
    [self insertWithDictionary:dic];
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
