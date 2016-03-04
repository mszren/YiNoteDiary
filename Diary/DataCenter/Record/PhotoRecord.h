//
//  PhotoRecord.h
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>

@interface PhotoRecord : CTPersistanceRecord
@property (nonatomic,copy) NSNumber *photoID;
@property (nonatomic,copy) NSNumber *travelID;
@property (nonatomic,copy) NSString *photoDesc;
@property (nonatomic,copy) NSString *photoURL;
@property (nonatomic,copy) NSString *travelLogo;
@property (nonatomic,assign) double createTime;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

@property (nonatomic,copy) NSString *photoImgPath;



- (instancetype)initWithTravelID:(NSNumber *)aTravelID
                        latitude:(double)aLatitude
                       longitude:(double)aLongitude;
@end
