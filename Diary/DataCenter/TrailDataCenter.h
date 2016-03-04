//
//  TrailDataCenter.h
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelRecord.h"

@interface TrailDataCenter : NSObject

+ (instancetype)shareInstance;

/**
 *  读取数据库游记记录
 *
 *  @return
 */
- (NSMutableArray *)loadTravelListData;

/**
 *  查询单条游记记录
 *
 *  @param uuid 游记UUID
 *
 *  @return
 */
- (TravelRecord *)selectTravelRecordByuuid:(NSString *)uuid;

/**
 *  插入单条游记记录
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (BOOL)insertTravelRecord:(TravelRecord *)travelRecord;

/**
 *  更新游记记录状态(结束亦或是开始）
 *
 *  @param travelId 游记记录travelId
 *
 *  @return
 */
- (BOOL)updateTravelFinish:(NSNumber *)travelId;

@end
