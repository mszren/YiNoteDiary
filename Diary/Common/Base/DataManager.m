//
//  DataManager.m
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()
@end
@implementation DataManager
- (NSDictionary *)fetchData:(NSDictionary *)rawData
                  ByAdapter:(id<AdapterProtocol>)adapter {
  if (adapter == nil) {
    return rawData;
  } else {
    return [adapter adapterData:rawData ByManager:self];
  }
}
@end