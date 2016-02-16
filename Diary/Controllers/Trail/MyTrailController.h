//
//  MyTrailController.h
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>

@interface MyTrailController : UIViewController <MessageRoutable>
@property (nonatomic,assign) BOOL isShowMember;

@property(nonatomic,strong) TravelEntity * currentTravelEntity;

@property(nonatomic,strong) MAMapView *mapView;

@end
