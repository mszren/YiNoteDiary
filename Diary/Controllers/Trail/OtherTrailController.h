//
//  OtherTrailController.h
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>
#import "TravelRecord.h"

@interface OtherTrailController : UIViewController <MessageRoutable>
//@property(nonatomic,strong) TravelEntity * currentTravelEntity;
@property (nonatomic,strong) TravelRecord *currentTravelRecord;
@property(nonatomic,strong) MAMapView *mapView;

@end
