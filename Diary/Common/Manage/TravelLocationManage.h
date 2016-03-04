//
//  TravelLocationManage.h
//  Common
//
//  Created by 曹亮 on 15/8/30.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>


@interface TravelLocationManage : NSObject

+ (instancetype)shareInstance;

- (void)startLocation;
- (void)stopLocation;

@property(nonatomic,assign,readonly)CLLocationCoordinate2D currentCoord;

@end
