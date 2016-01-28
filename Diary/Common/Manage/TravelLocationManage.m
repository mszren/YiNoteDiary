//
//  TravelLocationManage.m
//  Common
//
//  Created by 曹亮 on 15/8/30.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "WGS84TOGCJ02.h"

#import "TravelLocationManage.h"



@interface TravelLocationManage ()<CLLocationManagerDelegate>{
   CLLocationManager * _locationManager;
   CLLocationCoordinate2D _currentCoord;
}
@end

static TravelLocationManage *travelLocationManage;
@implementation TravelLocationManage
@synthesize currentCoord = _currentCoord;

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    travelLocationManage = [[self alloc] init];
  });
  return travelLocationManage;
}


- (instancetype)init{
  self = [super init];
  if (self) {
    _locationManager = [[CLLocationManager alloc] init];
    assert(_locationManager);
    _locationManager.delegate = self;
    if ([_locationManager
         respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
      [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = [[NSUserDefaults standardUserDefaults]
                                        doubleForKey:@"LocationTrackingAccuracyPrefsKey"];
    [_locationManager startUpdatingLocation];
  }
  return self;
}


#pragma mark -
#pragma mark startUpdatingLocation
- (void)startLocation{
  [_locationManager startUpdatingLocation];
}

- (void)stopLocation{
    [_locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
  if (locations != nil && locations.count > 0) {
    CLLocation *newLocation = locations[0];
    _currentCoord = newLocation.coordinate;
    
    //判断是不是属于国内范围
    if (![WGS84TOGCJ02 isLocationOutOfChina:[newLocation coordinate]]) {
      //转换后的coord
      _currentCoord =
      [WGS84TOGCJ02 transformFromWGSToGCJ:[newLocation coordinate]];
    }
  }
    
//    NSLog(@"long=%f,latitude=%f",_currentCoord.longitude,_currentCoord.latitude);
}



@end