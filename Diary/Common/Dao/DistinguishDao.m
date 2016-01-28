//
//  DistinguishDao.m
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

#import "DistinguishDao.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

#import "DistinguishEntity.h"

@implementation DistinguishDao

#pragma mark -
#pragma mark Initialization and teardown
- (id)init {
    return [self initWithTableName:@"distinguish" ClassName:@"DistinguishEntity"];
}

- (BOOL)insertWithModel:(DistinguishEntity *)aModel {
    NSDictionary *values = @{
                             kDistinguishImgNameKey : aModel.distinguishImgPath,
                             kDistinguishDescNameKey : aModel.distinguishDesc,
                             kDistinguishStartLatitudeNameKey : [NSNumber numberWithDouble:aModel.startLatitude],
                             kDistinguishStartLongitudeNameKey : [NSNumber numberWithDouble:aModel.startLongitude],
                             kDistinguishCreateTimeNameKey : [NSNumber numberWithDouble:aModel.createTime]
                             };
    return [self insertWithDictionary:values];
}



@end

