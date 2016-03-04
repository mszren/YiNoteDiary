//
//  TravelRecord.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>

typedef enum : NSUInteger {
    ETravelStart,
    ETravelFinish,
} TravelType;

@interface TravelRecord : CTPersistanceRecord 
@property (nonatomic,copy) NSNumber *travelID;
@property (nonatomic,copy) NSString *uuid;
@property (nonatomic,copy) NSString *travelName;
@property (nonatomic,copy) NSString *travelDesc;
@property (nonatomic,copy) NSString *travelLogo;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) double createTime;
@property (nonatomic,assign) double startLatitude;
@property (nonatomic,assign) double startLongitude;

@property (nonatomic,copy)NSMutableArray * imageList;
@property (nonatomic,copy)NSMutableArray * travelRouteList;

- (instancetype)initWithName:(NSString *)aName
                        logo:(NSString *)aLogo
                  travelDesc:(NSString *)aDesc;

@end
