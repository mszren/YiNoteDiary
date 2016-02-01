//
//  TravelDataManage.m
//  Common
//
//  Created by 曹亮 on 15/8/22.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "TravelDataManage.h"

@interface TravelDataManage ()

@end

static TravelDataManage *travelDataManage;
@implementation TravelDataManage

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    travelDataManage = [[self alloc] init];
  });
  return travelDataManage;
}

- (id)init {
  self = [super init];
  if (self) {
    photoDao = [[PhotoDao alloc] init];
    travelDao = [[TravelDao alloc] init];
    locationDao = [[LocationDao alloc] init];
      
    distinguishDao = [[DistinguishDao alloc] init];
  }
  return self;
}

/**
 *  travel
 *
 *  @return 
 */
- (BOOL)updateAllTravelFinish{
    return [travelDao updateAllTravelFinish];
}

- (BOOL)insertTravelEnity:(TravelEntity *)aTravelEntity {
  return [travelDao insertWithModel:aTravelEntity];
}

- (NSMutableArray *)loadTravelListData {
    NSMutableArray * resultList = [travelDao selectEntityList];
    for (TravelEntity * travelEntity  in resultList) {
        [travelEntity.imageList removeAllObjects];
        [travelEntity.imageList addObjectsFromArray:[photoDao selectListByTravelEntity:travelEntity]];
        [travelEntity.travelRouteList removeAllObjects];
        [travelEntity.travelRouteList addObjectsFromArray:[locationDao selectListByTravelEntity:travelEntity]];
    }
  return resultList;
}

- (TravelEntity *)selectTravelEntityByuuid:(NSString *)uuid{
    TravelEntity * restult= [travelDao selectModelByuuid:uuid];
    
    [restult.imageList removeAllObjects];
    [restult.imageList addObjectsFromArray:[photoDao selectListByTravelEntity:restult]];
    
    [restult.travelRouteList removeAllObjects];
    [restult.travelRouteList addObjectsFromArray:[locationDao selectListByTravelEntity:restult]];
    return restult;
}

- (TravelEntity *)selectTravelEntityById:(NSString *) travelId{
    TravelEntity * restult= [travelDao selectModelByID:travelId];
    
    [restult.imageList removeAllObjects];
    [restult.imageList addObjectsFromArray:[photoDao selectListByTravelEntity:restult]];
    
    [restult.travelRouteList removeAllObjects];
    [restult.travelRouteList addObjectsFromArray:[locationDao selectListByTravelEntity:restult]];
    return restult;
}

- (BOOL)updateTravelFinish:(NSString *)travelId{
    return [travelDao updateTravelFinish:travelId];
}

/**
 *  location
 *
 *  @param aLocationEntiry
 *
 *  @return
 */
- (BOOL)insertLocationEnity:(LocationEntity *)aLocationEntiry {
  return [locationDao insertWithModel:aLocationEntiry];
}

- (NSMutableArray *)loadLocationListData:(TravelEntity *)aTravelEntity {
  return [locationDao selectListByTravelEntity:aTravelEntity];
}

/**
 *  photo
 *
 *  @param photoEntity
 *
 *  @return
 */
- (BOOL)insertPhotoEnity:(PhotoEntity *)photoEntity {
  return [photoDao insertWithModel:photoEntity];
}

- (NSMutableArray *)loadPhotoListData:(TravelEntity *)aTravelEntity {
  return [photoDao selectListByTravelEntity:aTravelEntity];
}

/**
 *  Distinguish
 *
 *  @param BOOL
 *
 *  @return
 */
- (BOOL)insertDistinguish:(DistinguishEntity *)distinguishEntity{
    return [distinguishDao insertWithModel:distinguishEntity];
}
- (NSMutableArray *)loadDistinguishListData{
    return [distinguishDao selectEntityList];
}

@end
