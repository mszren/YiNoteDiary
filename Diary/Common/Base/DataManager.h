//
//  DataManager.h
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdapterProtocol.h"

@interface DataManager : NSObject
- (NSDictionary *)fetchData:(NSDictionary *)rawData
                  ByAdapter:(id<AdapterProtocol>)adapter;
@end
