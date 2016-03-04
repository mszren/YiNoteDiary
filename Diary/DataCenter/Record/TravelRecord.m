//
//  TravelRecord.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "TravelRecord.h"

@implementation TravelRecord

- (id)init{
    self = [super init];
    if (self) {
        
        _uuid = [[NSUUID UUID] UUIDString];
        _status = ETravelStart;
        
        _imageList = [[NSMutableArray alloc]initWithCapacity:0];
        _travelRouteList = [[NSMutableArray alloc]initWithCapacity:0];
        
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

@end
