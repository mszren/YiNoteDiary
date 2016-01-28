//
//  TravelImageCacheManage.m
//  Common
//
//  Created by 曹亮 on 8/29/15.
//  Copyright (c) 2015 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelImageCacheManage.h"
#import "PathHelper.h"

@interface TravelImageCacheManage ()

@end

static TravelImageCacheManage * travelImageCacheManage;
@implementation TravelImageCacheManage

#pragma mark -
#pragma mark Initialization and teardown
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        travelImageCacheManage = [[self alloc] init];
    });
    return travelImageCacheManage;
}

- (NSString *)saveImage:(UIImage *) aImg withType:(EntityType) aType{
    NSData *editImageData = UIImageJPEGRepresentation(aImg, 0.8f);
    NSData *smallImageData = UIImageJPEGRepresentation(aImg, 0.01f);
    NSString * imgName = [NSString stringWithFormat:@"%0.0f.jpg", [[NSDate date] timeIntervalSince1970] ];
    
    NSString *path;
    NSString *subPath;
    switch (aType) {
        case EDistinguishType:{
            subPath = [NSString stringWithFormat:@"%@/%@",Img_Dir_Name,@"Distinguish"] ;
            path = [PathHelper cacheDirectoryPathWithName:subPath];
            break;
        }
        case ETravleType:{
            subPath = [NSString stringWithFormat:@"%@/%@",Img_Dir_Name,@"travel"] ;
            path = [PathHelper cacheDirectoryPathWithName:subPath];
            break;
        }
        default:{
            break;
        }
    }
    [editImageData writeToFile:[path stringByAppendingPathComponent:imgName]atomically:YES];
    [smallImageData writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"small_%@",imgName]]atomically:YES];
    return [subPath stringByAppendingPathComponent:imgName];
}

- (NSString *)loadImgPath:(NSString *)subPath{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:subPath];
    
    return cachePath;
}


- (NSString *)loadSmallImgPath:(NSString *)subPath{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesPath = [paths objectAtIndex:0];
    

    NSString * imgName = [subPath lastPathComponent];
    
    NSString* cachePath = [cachesPath stringByAppendingPathComponent:[[subPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"small_%@",imgName]]];
    
    
    
    return cachePath;
}

@end

