//
//  ViewSpotModel.m
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//
#import "ViewSpotModel.h"
#import "LocationModel.h"

@implementation ViewSpotModel

#pragma mark -
#pragma mark Initialization and teardown

- (void)insertWithModel:(ViewSpotModel *)aModel {
  NSDictionary *values = @{
    @"travelID" : aModel.travleID,
    @"title" : aModel.title,
    @"desc" : aModel.desc,
    @"logoPath" : aModel.logoPath,
    @"latitude" : @(aModel.latitude),
    @"longitude" : @(aModel.longitude),
  };
  [self insertWithTable:@"viewspot" Dictionary:values];
}
@end
