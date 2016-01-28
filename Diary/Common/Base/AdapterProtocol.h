//
//  AdapterProtocol.h
//  Common
//
//  Created by Owen on 15/7/23.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AdapterProtocol <NSObject>
@required
- (id)adapterData:(NSDictionary *)rawData ByManager:(id)manager;
@end
