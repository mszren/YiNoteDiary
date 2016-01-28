//
//  DistinguishEntity.m
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

#import "DistinguishEntity.h"

@implementation DistinguishEntity
@synthesize distinguishID = _distinguishID;
@synthesize distinguishImgPath = _distinguishImgPath;
@synthesize distinguishDesc = _distinguishDesc;

@synthesize startLatitude = _startLatitude;
@synthesize startLongitude = _startLongitude;
@synthesize createTime = _createTime;

#pragma mark
#pragma mark-- initialization
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (instancetype)initWithImg:(NSString *)aImg
                       desc:(NSString *)aDesc{
    self = [super init];
    if (self) {
        _distinguishImgPath = aImg;
        _distinguishDesc = aDesc;
        
        _startLatitude = 0.0f;
        _startLongitude = 0.0f;
        _createTime = 0.0f;
    }
    return self;
}
- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.distinguishID = [dic objectForKey:kDistinguishIDNameKey] != [NSNull null]
        ? [dic objectForKey:kDistinguishIDNameKey]
        : @"";
        self.distinguishImgPath = [dic objectForKey:kDistinguishImgNameKey] != [NSNull null]
        ? [dic objectForKey:kDistinguishImgNameKey]
        : @"";
        self.distinguishDesc = [dic objectForKey:kDistinguishDescNameKey] != [NSNull null]
        ? [dic objectForKey:kDistinguishDescNameKey]
        : @"";
        self.startLatitude = [dic objectForKey:kDistinguishStartLatitudeNameKey] != [NSNull null]
        ? [[dic objectForKey:kDistinguishStartLatitudeNameKey] doubleValue]
        : 0.0f;
        self.startLongitude =
        [dic objectForKey:kDistinguishStartLongitudeNameKey] != [NSNull null]
        ? [[dic objectForKey:kDistinguishStartLongitudeNameKey] doubleValue]
        : 0;
        self.createTime =
        [dic objectForKey:kDistinguishCreateTimeNameKey] != [NSNull null]
        ? [[dic objectForKey:kDistinguishCreateTimeNameKey] doubleValue]
        : 0;
    }
    return self;
}


@end
