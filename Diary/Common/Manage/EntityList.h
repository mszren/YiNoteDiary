//
//  EntityList.h
//  Common
//
//  Created by 曹亮 on 15/8/24.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

typedef enum : NSUInteger {
    EDistinguishType,
    ETravleType,
} EntityType;


// travel
#define kTravelNameKeyID @"travelID"
#define kTravelNameKeyUUID @"uuid"
#define kTravelNameKeyName @"travelName"
#define kTravelNameKeyLogo @"travelLogo"
#define kTravelNameKeyDesc @"travelDesc"
#define kTravelNameKeyStatus @"status"
#define kTravelNameKeyCreateTime @"createTime"


#define kTravelNameKeyStartLatitude @"startLatitude"
#define kTravelNameKeyStartLongitude @"startLongitude"
#define kTravelNameKeyRoute @"kTravelDataKeyRoute"
#define kTravelNameKeyViewSpot @"kTravelDataKeyViewSpot"



// location
#define kLocationNameKeyID @"locationID"
#define kLocationNameKeyTravelID @"travelID"
#define kLocationNameKeyLatitude @"latitude"
#define kLocationNameKeyLongitude @"longitude"
#define kLocationNameKeyCreateTime @"createTime"

// photo
#define kPhotoNameKeyID @"photoID"
#define kPhotoNameKeyTravelID @"travelID"
#define kPhotoNameKeyDesc @"photoDesc"
#define kPhotoNameKeyURL @"photoURL"
#define kPhotoNameKeylatitude @"latitude"
#define kPhotoNameKeylongitude @"longitude"
#define kPhotoNameKeyCreateTime @"createTime"

// distinguish
#define kDistinguishIDNameKey @"distinguishID"
#define kDistinguishImgNameKey @"distinguishImg"
#define kDistinguishDescNameKey @"distinguishDesc"
#define kDistinguishStartLatitudeNameKey @"startLatitude"
#define kDistinguishStartLongitudeNameKey @"startLongitude"
#define kDistinguishCreateTimeNameKey @"createTime"




