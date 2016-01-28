//
//  TravelDao.h
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "BaseDBDao.h"

@class TravelEntity;

@interface TravelDao : BaseDBDao

- (BOOL)updateAllTravelFinish;
- (BOOL)updateTravelFinish:(NSString *) travelId;

- (TravelEntity *)selectModelByuuid:(NSString *)uuid;

- (TravelEntity *)selectModelByID:(NSString *)travelID;
@end
