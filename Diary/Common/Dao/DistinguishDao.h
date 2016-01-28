//
//  DistinguishDao.h
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

#import "BaseDBDao.h"

@class DistinguishEntity;

@interface DistinguishDao : BaseDBDao

- (BOOL)insertWithModel:(DistinguishEntity *)aModel;
@end
