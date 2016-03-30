//
//  LocationDatacenter.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "LocationDatacenter.h"
#import "LocationTable.h"

static LocationDatacenter * locationDatacenter;
@implementation LocationDatacenter{
    
    NSString *_tableName;
    LocationTable *_locationTable;
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        locationDatacenter = [[self alloc]init];
    });
    return locationDatacenter;
}

/**
 *  初始化表名，建表
 *
 *  @return
 */
- (id)init{
    
    self = [super init];
    if (self) {
        
        _tableName = @"location";
        _locationTable = [[LocationTable alloc]init];
    }
    return self;
}

/**
 *  查询位置信息(通过游记travelID)
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (NSArray *)selectListByLocationRecord:(TravelRecord *)travelRecord{
    
    NSString *newSql =
    [NSString stringWithFormat:@"Select * from %@ where %@ = %@ order by %@ desc",
     _tableName, kPhotoNameKeyTravelID,travelRecord.travelID,kPhotoNameKeyCreateTime];
    NSArray * resultArry = [_locationTable findAllWithSQL:newSql params:nil error:nil];
    return resultArry;
}

/**
 *  插入(保存)位置
 *
 *  @param photoRecord 位置信息
 */
- (void)insertLocationRecord:(LocationRecord *)locationRecord{
    
    [_locationTable insertRecord:locationRecord error:nil];
}

@end
