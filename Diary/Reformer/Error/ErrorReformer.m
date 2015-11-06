//
//  ErrorReformer.m
//  Diary
//
//  Created by Owen on 15/10/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ErrorReformer.h"

@implementation ErrorReformer
NSString *const kErrorCode = @"code";
NSString *const kErrorMessage = @"message";


- (id)manager:(LDAPIBaseManager *)manager reformData:(NSDictionary *)data
{
    return @{
             @"code" : data[kErrorCode] != [NSNull null]
             ? data[kErrorCode]
             : @"",
             @"message" : data[kErrorMessage] != [NSNull null]
             ? data[kErrorMessage]
             : @""
             };
}
@end
