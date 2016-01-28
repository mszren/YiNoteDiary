//
//  PhotoEntity.h
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoEntity : NSObject

@property(nonatomic, strong) NSString *photoID;
@property(nonatomic, strong) NSString *travelID;
@property(nonatomic, strong) NSString *photoDesc;
@property(nonatomic, strong) NSString *photoImgPath;

@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) double createTime;


- (instancetype)initWithTravelID:(NSString *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude;
@end
