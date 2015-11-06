//
//  LDURLResponse.h
//  Common
//
//  Created by Owen on 15/8/21.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDNetworkingConfiguration.h"

@interface LDURLResponse : NSObject

@property(nonatomic, assign, readonly) LDURLResponseStatus status;
@property(nonatomic, copy, readonly) NSString *contentString;
@property(nonatomic, copy, readonly) id content;
@property(nonatomic, assign, readonly) NSInteger requestId;
@property(nonatomic, copy, readonly) NSURLRequest *request;
@property(nonatomic, copy, readonly) NSData *responseData;
@property(nonatomic, copy) NSDictionary *requestParams;
@property(nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(LDURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;

@end
