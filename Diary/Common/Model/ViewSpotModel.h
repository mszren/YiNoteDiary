//
//  ViewSpotModel.h
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationModel;

@interface ViewSpotModel :  DBManager
@property(nonatomic, strong) NSString *viewspotID;
@property(nonatomic, strong) NSString *travleID;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *logoPath;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, strong) NSMutableArray *photos;

- (void)insertWithModel:(ViewSpotModel *)aModel;
@end
