//
//  PhotoDataCenter.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelRecord.h"
#import "PhotoRecord.h"

@interface PhotoDataCenter : NSObject

+ (instancetype)shareInstance;

/**
 *  查询照片(通过游记travelID)
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (NSArray *)selectListByTravelRecord:(TravelRecord *)travelRecord;

/**
 *  插入(保存)照片
 *
 *  @param photoRecord 照片信息
 */
- (void)insertPhotoRecord:(PhotoRecord *)photoRecord;
@end
