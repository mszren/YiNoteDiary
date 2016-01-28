//
//  LocationModel.m
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

#pragma mark -
#pragma mark Initialization and teardown

- (void)insertWithModel:(LocationModel *)aModel {
  NSDictionary *values = @{
    @"travelID" : aModel.travelID,
    @"latitude" : @(aModel.latitude),
    @"longitude" : @(aModel.longitude)
  };
  [self insertWithTable:@"location" Dictionary:values];
}
@end
