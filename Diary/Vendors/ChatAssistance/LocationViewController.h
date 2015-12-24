//
//  LocationViewController.h
//  Diary
//
//  Created by 我 on 15/12/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol LocationViewDelegate <NSObject>

-(void)sendLocationLatitude:(double)latitude
                  longitude:(double)longitude
                 andAddress:(NSString *)address;
@end

@interface LocationViewController : UIViewController

@property (nonatomic, assign) id<LocationViewDelegate> delegate;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)locationCoordinate;

@end
