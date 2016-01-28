//
//  TravelModel.m
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelModel.h"
#import "FMResultSet.h"

@implementation TravelModel

#pragma mark -
#pragma mark Initialization and teardown
- (id)initWithTravelID:(NSString *)travelID {
  self = [super init];
  if (self) {

    NSString *strSql = [NSString
        stringWithFormat:@"SELECT * FROM travel where travelID='%@'", travelID];
    NSDictionary *dic = [self getSingle:strSql];
    if (dic != nil) {
      self.travelID = [dic objectForKey:@"travelID"];
      self.travelName = [dic objectForKey:@"travelName"];
      self.createTime = [[dic objectForKey:@"createTime"] doubleValue];
    }

    strSql = [NSString
        stringWithFormat:@"SELECT * FROM viewspot where travelID='%@'",
                         travelID];
    NSArray *resultArr = [self getList:strSql];
    if (resultArr != nil) {
      self.viewspot = [NSMutableArray arrayWithArray:resultArr];
    } else {
      self.viewspot = [NSMutableArray arrayWithCapacity:0];
    }

    strSql = [NSString
        stringWithFormat:@"SELECT * FROM location where travelID='%@'",
                         travelID];
    resultArr = [self getList:strSql];
    if (resultArr != nil) {
      self.travelRoute = [NSMutableArray arrayWithArray:resultArr];
    } else {
      self.travelRoute = [NSMutableArray arrayWithCapacity:0];
    }
  }
  return self;
}

+ (TravelModel *)initWithDictionary:(NSDictionary *)dic {

  TravelModel *travel = [[TravelModel alloc] init];
  travel.travelID = [dic objectForKey:@"travelID"] != [NSNull null]
                        ? [dic objectForKey:@"travelID"]
                        : @"";
  travel.travelName = [dic objectForKey:@"travelName"] != [NSNull null]
                          ? [dic objectForKey:@"travelName"]
                          : @"";

  travel.createTime = [dic objectForKey:@"createTime"] != [NSNull null]
                          ? [[dic objectForKey:@"createTime"] doubleValue]
                          : 0.0;

  travel.status = [dic objectForKey:@"status"] != [NSNull null]
                      ? [[dic objectForKey:@"status"] integerValue]
                      : 0;
  return travel;
}

- (NSArray *)getTravelsByUserID:(NSInteger)userID {
  NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
  NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM  travel "];
  NSArray *arr = [self getList:strSql];
  if (arr != nil) {
    for (NSInteger i = 0; i < arr.count; i++) {
      NSDictionary *dic = [arr objectAtIndex:i];
      TravelModel *model = [TravelModel initWithDictionary:dic];
      [resultArr addObject:model];
    }
  }
  return resultArr;
}

// insert
- (void)insertWithModel:(TravelModel *)aModel {
  NSDictionary *values = [[NSDictionary alloc]
      initWithObjectsAndKeys:aModel.travelID, @"travelID", aModel.travelName,
                             @"travelName", @(aModel.createTime), @"createTime",
                             nil];
  [self insertWithTable:@"travel" Dictionary:values];
}

@end
