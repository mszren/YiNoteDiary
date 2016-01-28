//
//  TravelDataManage.h
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "PhotoDao.h"
#import "TravelDao.h"
#import "LocationDao.h"
#import "DistinguishDao.h"

@interface TravelDataManage : NSObject {
  PhotoDao *photoDao;
  TravelDao *travelDao;
  LocationDao *locationDao;
    DistinguishDao * distinguishDao;
}

+ (instancetype)shareInstance;

// travel
- (BOOL)insertTravelEnity:(TravelEntity *)aTravelEntity;
- (NSMutableArray *)loadTravelListData;
- (BOOL)updateAllTravelFinish;

- (TravelEntity *)selectTravelEntityByuuid:(NSString *)uuid;
- (TravelEntity *)selectTravelEntityById:(NSString *) travelId;

- (BOOL)updateTravelFinish:(NSString *)travelId;

// viewSpot
//- (BOOL)insertViewSpotEnity:(ViewSpotEntity *)aViewSpotEntity;
- (NSMutableArray *)loadViewSpotListData:(TravelEntity *)aTravelEntity;

// Location
- (BOOL)insertLocationEnity:(LocationEntity *)aLocationEntiry;
- (NSMutableArray *)loadLocationListData:(TravelEntity *)aTravelEntity;

// Photo
- (BOOL)insertPhotoEnity:(PhotoEntity *)photoEntity;
//- (NSMutableArray *)loadPhotoListData:(ViewSpotEntity *)viewSpotEntity;


// Distinguish
- (BOOL)insertDistinguish:(DistinguishEntity *)distinguishEntity;
- (NSMutableArray *)loadDistinguishListData;

@end
