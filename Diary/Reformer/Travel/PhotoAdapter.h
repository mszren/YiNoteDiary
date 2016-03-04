//
//  PhotoAdapter.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>
#import "AdapterProtocol.h"
#import "PhotoAdapterKeys.h"

@interface PhotoAdapter : CTPersistanceRecord <AdapterProtocol>

@end
