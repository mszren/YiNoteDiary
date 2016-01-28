//
//  LocationDao.m
//  Common
//
//  Created by 曹亮 on 15/8/23.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LocationDao.h"
#import "TravelModel.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation LocationDao

#pragma mark -
#pragma mark Initialization and teardown
- (id)init {
  return [self initWithTableName:@"location" ClassName:@"LocationEntity"];
}

- (BOOL)insertWithModel:(LocationEntity *)aModel {
  NSDictionary *values = @{
    kLocationNameKeyTravelID : aModel.travelID,
    kLocationNameKeyCreateTime : [NSNumber numberWithDouble:aModel.createTime],
    kLocationNameKeyLatitude : [NSNumber numberWithDouble:aModel.latitude],
    kLocationNameKeyLongitude : [NSNumber numberWithDouble:aModel.longitude]
  };
  return [self insertWithDictionary:values];
}


- (NSMutableArray *)selectListByTravelEntity:(TravelEntity *)entity {
    NSString *newSql =
    [NSString stringWithFormat:@"Select * from %@ where %@ ='%@'  order by %@ desc ",
     self.tableName,kLocationNameKeyTravelID,entity.travelID,kLocationNameKeyCreateTime];
    NSMutableArray *resultArr = [self query:newSql];
    return resultArr;
}

@end
