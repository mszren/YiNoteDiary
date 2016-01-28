//
//  PhotoEntity.m
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "PhotoEntity.h"

@implementation PhotoEntity

#pragma mark -
#pragma mark Initialization and teardown
- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithTravelID:(NSString *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude{
    self = [super init];
    if (self) {
        _travelID = aTravelID;
        _latitude = aLatitude;
        _longitude = aLongitude;
        
        _photoDesc = @"";
    }
    return self;
}




- (id)initWithDictionary:(NSDictionary *)dic {
  self = [super init];
  if (self) {
      self.photoID = [dic objectForKey:kPhotoNameKeyID] != [NSNull null]
      ? [dic objectForKey:kPhotoNameKeyID]
      : @"";
      self.travelID = [dic objectForKey:kPhotoNameKeyTravelID] != [NSNull null]
      ? [dic objectForKey:kPhotoNameKeyTravelID]
      : @"";
      self.photoDesc = [dic objectForKey:kPhotoNameKeyDesc] != [NSNull null]
      ? [dic objectForKey:kPhotoNameKeyDesc]
      : @"";
      self.photoImgPath = [dic objectForKey:kPhotoNameKeyURL] != [NSNull null]
      ? [dic objectForKey:kPhotoNameKeyURL]
      : @"";
      self.latitude =
      [dic objectForKey:kPhotoNameKeylatitude] != [NSNull null]
      ? [[dic objectForKey:kPhotoNameKeylatitude] doubleValue]
      : 0.f;
      self.longitude =
      [dic objectForKey:kPhotoNameKeylongitude] != [NSNull null]
      ? [[dic objectForKey:kPhotoNameKeylongitude] doubleValue]
      : 0.f;
      self.createTime =
      [dic objectForKey:kPhotoNameKeyCreateTime] != [NSNull null]
      ? [[dic objectForKey:kPhotoNameKeyCreateTime] doubleValue]
      : 0;
  }
  return self;
}
@end
