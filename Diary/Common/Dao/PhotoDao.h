//
//  PhotoDao.h
//  Common
//
//  Created by 曹亮 on 15/8/23.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "BaseDBDao.h"

@class PhotoEntity;

@interface PhotoDao : BaseDBDao


- (NSMutableArray *)selectListByTravelEntity:(TravelEntity *)entity;
@end
