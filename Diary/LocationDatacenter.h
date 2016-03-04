//
//  LocationDatacenter.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelRecord.h"
#import "LocationRecord.h"

@interface LocationDatacenter : NSObject

+ (instancetype)shareInstance;

/**
 *  查询位置信息(通过游记travelID)
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (NSArray *)selectListByLocationRecord:(TravelRecord *)travelRecord;


/**
 *  插入(保存)位置
 *
 *  @param photoRecord 位置信息
 */
- (void)insertLocationRecord:(LocationRecord *)locationRecord;


@end
