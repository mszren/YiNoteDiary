//
//  LocationView.h
//  Diary
//
//  Created by 我 on 15/12/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationView : NSObject <MKMapViewDelegate>
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)MKMapView * mapView;

+ (instancetype)sharedInstance;

- (void)showLocationView:(NSDictionary *)locationDic;

@end
