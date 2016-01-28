//
//  LocationManager.m
//  Diary
//
//  Created by Owen on 15/11/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LocationManager.h"
#import "WGS84TOGCJ02.h"

@interface LocationManager()<CLLocationManagerDelegate>{
    CLLocationManager * _locationManager;
}

@end


static LocationManager *locationManager;
@implementation LocationManager

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[self alloc] init];
    });
    return locationManager;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        assert(_locationManager);
        _locationManager.delegate = self;
        // 3. 定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            //[_locationManager requestWhenInUseAuthorization];//?只在前台开启定位
            [_locationManager requestAlwaysAuthorization];//?在后台也可定位
        }
        // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }

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
    
//        NSLog(@"long=%f,latitude=%f",_currentCoord.longitude,_currentCoord.latitude);
}



@end
