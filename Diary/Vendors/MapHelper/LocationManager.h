//
//  LocationManager.h
//  Diary
//
//  Created by Owen on 15/11/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

@property (nonatomic,assign,readonly) CLLocationCoordinate2D currentCoord;

+(instancetype)shareInstance;

-(void)startLocation;
-(void)stopLocation;


@end
