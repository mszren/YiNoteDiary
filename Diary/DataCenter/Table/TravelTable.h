//
//  TravelTable.h
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CTPersistanceTable.h"

@interface TravelTable : CTPersistanceTable<CTPersistanceTableProtocol>
@property (nonatomic,assign) Class recordClass;
@end
