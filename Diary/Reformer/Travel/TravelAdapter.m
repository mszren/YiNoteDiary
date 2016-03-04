//
//  TravelAdapter.m
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelAdapter.h"
#import "TravelDBManager.h"

@implementation TravelAdapter
NSString *const kTravelDataKeyID = @"kTravelDataKeyID";
NSString *const kTravelDataKeyName = @"kTravelDataKeyName";
NSString *const kTravelDataKeyLogo = @"kTravelDataKeyLogo";
NSString *const kTravelDataKeyDesc = @"kTravelDataKeyDesc";
NSString *const kTravelDataKeyStatus = @"kTravelDataKeyStatus";
NSString *const kTravelDataKeyCreateTime = @"kTravelDataKeyCreateTime";
NSString *const kTravelDataKeyRoute = @"kTravelDataKeyRoute";
NSString *const kTravelDataKeyViewSpot = @"kTravelDataKeyViewSpot";
NSString *const KTravelDataKeyStartLatitude = @"KTravelDataKeyStartLatitude";
NSString *const KTravelDataKeyStartLongitude = @"KTravelDataKeyStartLongitude";


- (NSDictionary *)adapterData:(NSDictionary *)rawData
                    ByManager:(DataManager *)manager {
  NSDictionary *resultData = nil;

  if ([manager isKindOfClass:[TravelDBManager class]]) {

    resultData = @{
      @"travelID" : rawData[kTravelDataKeyID] != [NSNull null]
                        ? rawData[kTravelDataKeyID]
                        : @"",
      @"travelName" : rawData[kTravelDataKeyName] != [NSNull null]
                          ? rawData[kTravelDataKeyName]
                          : @"",
      @"travelLogo" : rawData[kTravelDataKeyLogo] != [NSNull null]
                          ? rawData[kTravelDataKeyLogo]
                          : @"",
      @"travelDesc" : rawData[kTravelDataKeyDesc] != [NSNull null]
                          ? rawData[kTravelDataKeyDesc]
                          : @"",
      @"status" : rawData[kTravelDataKeyStatus] != [NSNull null]
                      ? rawData[kTravelDataKeyStatus]
                          : @"",
      @"createTime" : rawData[kTravelDataKeyCreateTime] != [NSNull null]
                          ? rawData[kTravelDataKeyCreateTime]
                          : @"",
      @"startLatitude" : rawData[KTravelDataKeyStartLatitude] != [NSNull null]
                           ? rawData[KTravelDataKeyStartLatitude]
                          : @"",
      @"startLongitude" : rawData[KTravelDataKeyStartLongitude] != [NSNull null]
                            ? rawData[KTravelDataKeyStartLongitude]
                           : @""
    };
  }
  return resultData;
}

@end
