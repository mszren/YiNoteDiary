//
//  BusinessBaseManager.m
//  Diary
//
//  Created by Owen on 15/11/9.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "BusinessBaseManager.h"
@interface BusinessBaseManager()

@end

@implementation BusinessBaseManager
- (void)businessCallDidSuccess:(BusinessBaseManager *)manager {
    if ([self.delegate
         respondsToSelector:@selector(businessManagerCallDidSuccess:)]) {
          [self.delegate businessManagerCallDidSuccess:self];
         }
}

@end
