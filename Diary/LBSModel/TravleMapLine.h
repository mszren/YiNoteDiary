//
//  TravleMapLine.h
//  LightDiary
//
//  Created by 曹亮 on 15/9/6.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <MAMapKit/MAPolyline.h>
#import "TravelRecord.h"

@interface TravleMapLine : MAPolyline{


}
@property(nonatomic,strong)TravelRecord *travelRecord;
//@property(nonatomic,strong)TravelEntity * travelEntity;
@property(nonatomic,assign)NSUInteger index;


@end
