//
//  TravelModel.h
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"

@interface TravelModel : DBManager
@property(nonatomic, copy) NSString *travelID;
@property(nonatomic, copy) NSString *travelName;
@property(nonatomic, copy) NSString *travelLogo;
@property(nonatomic, assign) NSTimeInterval createTime;
@property(nonatomic, assign) NSUInteger status;
@property(nonatomic, strong) LocationModel *startLocation;
@property(nonatomic, strong) LocationModel *endLocation;

@property(nonatomic, strong) NSMutableArray *travelRoute;
@property(nonatomic, strong) NSMutableArray *viewspot;

+ (id)initWithDictionary:(NSDictionary *)dic;

- (id)initWithTravelID:(NSString *)travelID;
- (void)insertWithModel:(TravelModel *)aModel;
- (NSArray *)getTravelsByUserID:(NSInteger)userID;
@end
