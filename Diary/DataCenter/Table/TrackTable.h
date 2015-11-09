//
//  Track.h
//  Diary
//
//  Created by Owen on 15/11/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CTPersistanceTable.h"

@interface TrackTable : CTPersistanceTable<CTPersistanceTableProtocol>
@property (nonatomic,assign) Class recordClass;
@end
