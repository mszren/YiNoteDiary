//
//  LocationEntity.h
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationEntity : NSObject

@property(nonatomic, assign) NSInteger locationID;
@property(nonatomic, strong) NSString *travelID;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) double createTime;

- (instancetype)initWithTravelID:(NSString *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude;

@end
