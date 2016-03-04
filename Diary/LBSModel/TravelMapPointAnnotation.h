//
//  TravelMapPointAnnotation.h
//  LightDiary
//
//  Created by 曹亮 on 15/9/6.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <MAMapKit/MAPointAnnotation.h>
#import "TravelRecord.h"
#import "PhotoRecord.h"

@interface TravelMapPointAnnotation : MAPointAnnotation{
    
    
}
@property(nonatomic,strong)TravelRecord *travelRecord;
@property(nonatomic,strong)PhotoRecord *photoRecord;

//@property(nonatomic,strong)TravelEntity * travelEntity;
//@property(nonatomic,strong)PhotoEntity * photoEntity;

@property(nonatomic,assign)NSUInteger index;


@end
