//
//  LocationRecord.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "LocationRecord.h"

@implementation LocationRecord

- (instancetype)initWithTravelID:(NSNumber *)aTravelID latitude:(double)aLatitude longitude:(double)aLongitude{
    self = [super init];
    if (self) {
        int travelID = [aTravelID intValue];
        _travelID = [NSNumber numberWithInt:travelID];
        _latitude = aLatitude;
        _longitude = aLongitude;
    }
    return self;
}

@end
