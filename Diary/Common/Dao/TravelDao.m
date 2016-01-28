//
//  TravelDao.m
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelDao.h"

#import "TravelEntity.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation TravelDao

#pragma mark -
#pragma mark Initialization and teardown
- (id)init {
  return [self initWithTableName:@"travel" ClassName:@"TravelEntity"];
}


- (NSMutableArray *)selectEntityList {
    NSString *newSql =
    [NSString stringWithFormat:@"select * from %@ order by %@ desc", self.tableName,kTravelNameKeyCreateTime];
    NSMutableArray *resultArr = [self query:newSql];
    return resultArr;
}

- (BOOL)updateAllTravelFinish{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set %@ = %ld",tableName,kTravelNameKeyStatus, ETravelFinish];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}

- (BOOL)updateTravelFinish:(NSString *) travelId{
    BOOL success = YES;
    
    NSString * sql = [NSString stringWithFormat:@"update %@  set %@ = %ld where %@ = '%@'",tableName,kTravelNameKeyStatus, ETravelFinish,kTravelNameKeyID ,travelId];
    [db executeUpdate:sql];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
    return success;
}


- (TravelEntity *)selectModelByuuid:(NSString *)uuid{
    NSString * newSql = [NSString stringWithFormat:@"SELECT * FROM %@ where %@ = '%@'",tableName,kTravelNameKeyUUID,uuid];
    NSMutableArray * resultArr = [self query:newSql];
    if(resultArr.count){
        return [resultArr objectAtIndex:0];
    }else{
        return nil;
    }
}
- (TravelEntity *)selectModelByID:(NSString *)travelID{
    NSString * newSql = [NSString stringWithFormat:@"SELECT * FROM %@ where %@ = '%@'",tableName,kTravelNameKeyID,travelID];
    NSMutableArray * resultArr = [self query:newSql];
    if(resultArr.count){
        return [resultArr objectAtIndex:0];
    }else{
        return nil;
    }
}

// insert
- (BOOL)insertWithModel:(TravelEntity *)aModel {
  NSDictionary *values = @{
    kTravelNameKeyName : aModel.travelName,
    kTravelNameKeyDesc : aModel.travelDesc,
    kTravelNameKeyUUID : aModel.uuid,
    kTravelNameKeyStatus : [NSNumber numberWithInt:aModel.status],
    kTravelNameKeyStartLatitude :
        [NSNumber numberWithDouble:aModel.startLatitude],
    kTravelNameKeyStartLongitude :
        [NSNumber numberWithDouble:aModel.startLongitude],
    kTravelNameKeyCreateTime : [NSNumber numberWithDouble:aModel.createTime]
  };

  return [self insertWithDictionary:values];
}

@end
