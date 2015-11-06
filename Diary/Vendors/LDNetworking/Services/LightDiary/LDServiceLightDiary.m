//
//  LDServiceLightDiary.m
//  Common
//
//  Created by Owen on 15/8/26.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "LDServiceLightDiary.h"

@implementation LDServiceLightDiary
#pragma mark - LDServiceProtocal
- (BOOL)isOnline {
  return YES;
}

- (NSString *)onlineApiBaseUrl {
  return @"http://123.56.225.133/";
}

- (NSString *)onlineApiVersion {
  return @"v1";
}

- (NSString *)onlinePrivateKey {
  return @"";
}

- (NSString *)onlinePublicKey {
  return @"";
}

- (NSString *)offlineApiBaseUrl {
  return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion {
  return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey {
  return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey {
  return self.onlinePublicKey;
}

@end
