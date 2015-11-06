//
//  LDCachedObject.m
//  LDNetworking
//
//  Created by casa on 14-5-26.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "LDCachedObject.h"
#import "LDNetworkingConfiguration.h"

@interface LDCachedObject ()

@property(nonatomic, copy, readwrite) NSData *content;
@property(nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation LDCachedObject

#pragma mark - getters and setters
- (BOOL)isEmpty {
  return self.content == nil;
}

- (BOOL)isOutdated {
  NSTimeInterval timeInterval =
      [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
  return timeInterval > kLDCacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content {
  _content = [content copy];
  self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSData *)content {
  self = [super init];
  if (self) {
    self.content = content;
  }
  return self;
}

#pragma mark - public method
- (void)updateContent:(NSData *)content {
  self.content = content;
}

@end
