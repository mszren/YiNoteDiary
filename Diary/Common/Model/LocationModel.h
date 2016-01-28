//
//  LocationModel.h
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"

@interface LocationModel : BaseDao
@property(nonatomic, assign) NSInteger locationID;
@property(nonatomic, strong) NSString *travelID;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;

- (void)insertWithModel:(LocationModel *)aModel;
@end
