//
//  DataProtocol.h
//  Common
//
//  Created by Owen on 15/8/20.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdapterProtocol.h"

@protocol DataProtocol <NSObject>
@required
@property(nonatomic, strong, readwrite) id fetchedRawData;
@required
- (id)fetchDataWithAdapter:(id<AdapterProtocol>)adapter;
@end
