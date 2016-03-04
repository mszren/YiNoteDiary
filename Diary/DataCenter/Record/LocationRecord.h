//
//  LocationRecord.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>

@interface LocationRecord : CTPersistanceRecord
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *travelID;
@property (nonatomic,assign) double createTime;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

- (instancetype)initWithTravelID:(NSNumber *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude;

@end
