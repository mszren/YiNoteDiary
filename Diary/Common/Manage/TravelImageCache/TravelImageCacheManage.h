//
//  TravelImageCacheManage.h
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

@interface TravelImageCacheManage : NSObject
#import "EntityList.h"

+ (instancetype)shareInstance;


// 存储一张图片到 cache ，返回图片的相对路径
- (NSString *)saveImage:(UIImage *) aImg withType:(EntityType) aType;


- (NSString *)loadImgPath:(NSString *)subPath;

- (NSString *)loadSmallImgPath:(NSString *)subPath;
@end
