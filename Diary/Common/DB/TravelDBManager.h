//
//  TravelDBManager.h
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "DBManager.h"

@interface TravelDBManager : DBManager
- (NSArray *)getTravelsByUserID:(NSInteger)userID;
- (void)addTravel:(NSDictionary *)dic;
@end
