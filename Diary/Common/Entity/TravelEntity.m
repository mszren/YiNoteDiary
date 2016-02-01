//
//  TravelEntity.m
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelEntity.h"

@implementation TravelEntity

#pragma mark
#pragma mark-- initialization
- (instancetype)init {
  self = [super init];
  if (self) {
      _uuid = [[NSUUID UUID] UUIDString];
      _status = ETravelStart;
      
      _imageList = [[NSMutableArray alloc] initWithCapacity:0];
      _travelRouteList = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}

- (instancetype)initWithName:(NSString *)aName
                        logo:(NSString *)aLogo
                  travelDesc:(NSString *)aDesc {
  self = [self init];
  if (self) {
    _travelName = aName;
    _travelLogo = aLogo;
    _travelDesc = aDesc;

  }
  return self;
}

- (id)initWithDictionary:(NSDictionary *)dic {
  self = [self init];
  if (self) {
    self.travelID = [dic objectForKey:kTravelNameKeyID] != [NSNull null]
                        ? [dic objectForKey:kTravelNameKeyID]
                        : @"";
    self.travelName = [dic objectForKey:kTravelNameKeyName] != [NSNull null]
                          ? [dic objectForKey:kTravelNameKeyName]
                          : @"";
    self.travelDesc = [dic objectForKey:kTravelNameKeyDesc] != [NSNull null]
                          ? [dic objectForKey:kTravelNameKeyDesc]
                          : @"";
    self.travelLogo = [dic objectForKey:kTravelNameKeyLogo] != [NSNull null]
                          ? [dic objectForKey:kTravelNameKeyLogo]
                          : @"";
    self.createTime =
        [dic objectForKey:kTravelNameKeyCreateTime] != [NSNull null]
            ? [[dic objectForKey:kTravelNameKeyCreateTime] doubleValue]
            : 0;

    self.startLatitude =
        [dic objectForKey:kTravelNameKeyStartLatitude] != [NSNull null]
            ? [[dic objectForKey:kTravelNameKeyStartLatitude] doubleValue]
            : 0;
    self.startLongitude =
        [dic objectForKey:kTravelNameKeyStartLongitude] != [NSNull null]
            ? [[dic objectForKey:kTravelNameKeyStartLongitude] doubleValue]
            : 0;
      
    self.uuid =
      [dic objectForKey:kTravelNameKeyUUID] != [NSNull null]
      ? [dic objectForKey:kTravelNameKeyUUID]
      : @"";
      
      self.status =   [dic objectForKey:kTravelNameKeyStatus] != [NSNull null]
      ? [[dic objectForKey:kTravelNameKeyStatus] integerValue]
      : 0;
  }
  return self;
}

- (NSString *)description{
     return  [NSString stringWithFormat:@"travelID=%@,uuid=%@,startLatitude=%lf,startLongitude=%lf,createTime=%lf,imageList=%ld,travelRouteList=%ld",self.travelID,self.uuid,self.startLatitude,self.startLongitude,self.createTime,self.imageList.count,self.travelRouteList.count];
}

@end
