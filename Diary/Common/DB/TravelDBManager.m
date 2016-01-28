//
//  TravelDBManager.m
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelDBManager.h"

@implementation TravelDBManager
- (NSArray *)getTravelsByUserID:(NSInteger)userID {
  NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM  travel "];
  return [self getList:strSql];
}

- (void)addTravel:(NSDictionary *)dic {
  [self insertWithTable:@"travel" Dictionary:dic];
}
@end
