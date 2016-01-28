//
//  DistinguishEntity.h
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

#import "LocationEntity.h"

@interface DistinguishEntity : NSObject {
}

@property(nonatomic, strong) NSString *distinguishID;
@property(nonatomic, strong) NSString *distinguishImgPath;
@property(nonatomic, strong) NSString *distinguishDesc;

@property(nonatomic, assign) double startLatitude;
@property(nonatomic, assign) double startLongitude;
@property(nonatomic, assign) double createTime;

- (instancetype)initWithImg:(NSString *)aImg desc:(NSString *)aDesc;

@end
