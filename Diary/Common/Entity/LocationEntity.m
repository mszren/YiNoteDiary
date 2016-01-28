//
//  LocationEntity.m
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LocationEntity.h"

@implementation LocationEntity

#pragma mark -
#pragma mark Initialization and teardown

- (instancetype)initWithTravelID:(NSString *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude{
    self = [super init];
    if (self) {
        _travelID = aTravelID;
        _latitude = aLatitude;
        _longitude = aLongitude;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic {
  self = [super init];
  if (self) {
    self.locationID = [[dic objectForKey:kLocationNameKeyID] integerValue];
    self.travelID = [dic objectForKey:kLocationNameKeyTravelID];
    self.latitude =
        [dic objectForKey:kLocationNameKeyLatitude] != [NSNull null]
            ? [[dic objectForKey:kLocationNameKeyLatitude] doubleValue]
            : 0.f;
    self.longitude =
        [dic objectForKey:kLocationNameKeyLongitude] != [NSNull null]
            ? [[dic objectForKey:kLocationNameKeyLongitude] doubleValue]
            : 0.f;
      
      self.createTime =
      [dic objectForKey:kLocationNameKeyCreateTime] != [NSNull null]
      ? [[dic objectForKey:kLocationNameKeyCreateTime] doubleValue]
      : 0;
  }
  return self;
}

@end
