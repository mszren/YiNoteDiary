//
//  TravelAdapter.h
//  Common
//
//  Created by Owen on 15/8/12.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdapterProtocol.h"
#import "TravelAdapterKeys.h"
#import <CTPersistance/CTPersistance.h>
@interface TravelAdapter : CTPersistanceRecord <AdapterProtocol>

@end
