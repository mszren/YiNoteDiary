//
//  BusinessBaseManager.h
//  Diary
//
//  Created by Owen on 15/11/9.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ErrorReformer.h"
@class BusinessBaseManager;

// 业务回调
@protocol BusinessManagerCallBackDelegate <NSObject>
@required
- (void)businessManagerCallDidSuccess:(BusinessBaseManager *)manager;
@end

@interface BusinessBaseManager : NSObject
@property(nonatomic, weak)  id virtualRecord;
@property(nonatomic, copy)  LDAPIBaseManager* apiManager;
@property(nonatomic, weak) id<BusinessManagerCallBackDelegate> delegate;

- (void)businessCallDidSuccess:(BusinessBaseManager *)manager;
@end
