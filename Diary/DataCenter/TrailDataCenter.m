//
//  TrailDataCenter.m
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TrailDataCenter.h"
#import "PhotoDataCenter.h"
#import "LocationDatacenter.h"
#import "TravelTable.h"
#import "LocationTable.h"
#import "PhotoTable.h"

static TrailDataCenter * trailDataCenter;
@implementation TrailDataCenter{
    
    NSString *_tableName;
    TravelTable *_travelTable;
    PhotoDataCenter *photoDataCenter;
    LocationDatacenter *locationDatacenter;
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        trailDataCenter = [[self alloc]init];
    });
    return trailDataCenter;
}

/**
 *  初始化表名，建表
 *
 *  @return
 */
- (id)init{
    
    self = [super init];
    if (self) {
        
        _tableName = @"Travel";
        _travelTable = [[TravelTable alloc]init];
        photoDataCenter = [[PhotoDataCenter alloc]init];
        locationDatacenter = [[LocationDatacenter alloc]init];
    }
    return self;
}

/**
 *  读取数据库游记记录
 *
 *  @return
 */
- (NSMutableArray *)loadTravelListData{
    
    
    NSString *newSql =
    [NSString stringWithFormat:@"select * from %@ order by %@ desc", _tableName,kTravelNameKeyCreateTime];
    NSError *error = nil;
    NSArray *resultArr = [_travelTable findAllWithSQL:newSql params:nil error:&error];
    
    NSMutableArray *resultList = [NSMutableArray arrayWithArray:resultArr];
    for (TravelRecord *travelRecord in resultList) {
        [travelRecord.imageList removeAllObjects];
        [travelRecord.imageList addObjectsFromArray:[photoDataCenter selectListByTravelRecord:travelRecord]];
        
        [travelRecord.travelRouteList removeAllObjects];
        [travelRecord.travelRouteList addObjectsFromArray:[locationDatacenter selectListByLocationRecord:travelRecord]];
    }
    return resultList;
}


/**
 *  查询单条游记记录
 *
 *  @param uuid 游记UUID
 *
 *  @return
 */
- (TravelRecord *)selectTravelRecordByuuid:(NSString *)uuid{
    
    NSString *newSql = [NSString stringWithFormat:@"SELECT * FROM %@ where %@ = '%@'",_tableName,kTravelNameKeyUUID,uuid];
    TravelRecord *restult = (TravelRecord *)[_travelTable findAllWithSQL:newSql params:nil error:nil][0];
    
    [restult.imageList removeAllObjects];
    [restult.imageList addObjectsFromArray:[photoDataCenter selectListByTravelRecord:restult]];
    
    [restult.travelRouteList removeAllObjects];
    [restult.travelRouteList addObjectsFromArray:[locationDatacenter selectListByLocationRecord:restult]];
    
    return restult;
}


/**
 *  插入单条游记记录
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (BOOL)insertTravelRecord:(TravelRecord *)travelRecord{
    BOOL success = YES;
    NSError *error = nil;
    [_travelTable insertRecord:travelRecord error:&error];
    if (error) {
        success = NO;
    }
    return success;
}

/**
 *  更新游记记录状态(结束亦或是开始）
 *
 *  @param travelId 游记记录travelId
 *
 *  @return
 */
- (BOOL)updateTravelFinish:(NSNumber *)travelId{
    
    BOOL success = YES;
   
    int travelID = [travelId intValue];
    NSError *error = nil;
    TravelRecord *travelRecord = (TravelRecord *)[_travelTable findWithPrimaryKey:@(travelID) error:&error];
    travelRecord.status = ETravelFinish;
    [_travelTable updateRecord:travelRecord error:&error];
    if (error) {
        success = NO;
    }
    return success;
}


@end
