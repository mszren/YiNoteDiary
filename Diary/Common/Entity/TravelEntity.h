//
//  TravelEntity.h
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LocationEntity.h"

typedef enum : NSUInteger {
    ETravelStart,
    ETravelFinish,
} TravelType;

@interface TravelEntity : NSObject {
}

@property(nonatomic, assign) TravelType status;
@property(nonatomic, strong) NSString *travelID;
@property(nonatomic, strong) NSString *uuid;
@property(nonatomic, strong) NSString *travelName;
@property(nonatomic, strong) NSString *travelDesc;
@property(nonatomic, strong) NSString *travelLogo;
@property(nonatomic, strong) LocationEntity *startLocation;
@property(nonatomic, strong) LocationEntity *endLocation;

@property(nonatomic, strong) NSMutableArray *viewspot;

@property(nonatomic, assign) double startLatitude;
@property(nonatomic, assign) double startLongitude;
@property(nonatomic, assign) double createTime;


@property(nonatomic, strong) NSMutableArray *imageList;
@property(nonatomic, strong) NSMutableArray *travelRouteList;



- (instancetype)initWithName:(NSString *)aName
                        logo:(NSString *)aLogo
                  travelDesc:(NSString *)aDesc;

@end
