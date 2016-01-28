//
//  PhotoModel.m
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (void)insertWithModel:(PhotoModel *)aModel {
  NSDictionary *values = @{
    @"photoID" : aModel.photoID,
    @"viewspotID" : aModel.viewspotID,
    @"photoName" : aModel.photoName,
    @"photoURL" : aModel.photoURL,
    @"photoLocalPath" : aModel.photoLocalPath,
    @"createTime" : @(aModel.createTime)
  };
  [self insertWithTable:@"photo" Dictionary:values];
}
@end
