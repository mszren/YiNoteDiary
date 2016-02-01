//
//  PhotoDao.m
//  Common
//
//  Created by 曹亮 on 15/8/23.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "PhotoDao.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation PhotoDao

#pragma mark -
#pragma mark Initialization and teardown
- (id)init {
    
  return [self initWithTableName:@"photo" ClassName:@"PhotoEntity"];
}

- (BOOL)insertWithModel:(PhotoEntity *)aModel {
  NSDictionary *values = @{
    kPhotoNameKeyTravelID : aModel.travelID,
    kPhotoNameKeyDesc : aModel.photoDesc,
    kPhotoNameKeyURL : aModel.photoImgPath,
    kPhotoNameKeylatitude : [NSNumber numberWithDouble:aModel.latitude],
    kPhotoNameKeylongitude : [NSNumber numberWithDouble:aModel.longitude],
    kPhotoNameKeyCreateTime : [NSNumber numberWithDouble:aModel.createTime],
  };
  return [self insertWithDictionary:values];
}

- (NSMutableArray *)selectListByTravelEntity:(TravelEntity *)entity {
  NSString *newSql =
      [NSString stringWithFormat:@"Select * from %@ where %@ = %@ order by %@ desc",
                                 self.tableName, kPhotoNameKeyTravelID,entity.travelID,kPhotoNameKeyCreateTime];
  NSMutableArray *resultArr = [self query:newSql];
  return resultArr;
}

@end
