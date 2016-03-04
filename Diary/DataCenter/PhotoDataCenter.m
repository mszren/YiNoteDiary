//
//  PhotoDataCenter.m
//  Diary
//
//  Created by 我 on 16/3/3.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "PhotoDataCenter.h"
#import "PhotoTable.h"

static PhotoDataCenter * photoDataCenter;
@implementation PhotoDataCenter{
    
    NSString *_tableName;
    PhotoTable *_photoTable;
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        photoDataCenter = [[self alloc]init];
    });
    return photoDataCenter;
}

/**
 *  初始化表名，建表
 *
 *  @return
 */
- (id)init{
    
    self = [super init];
    if (self) {
        
        _tableName = @"Photo";
        _photoTable = [[PhotoTable alloc]init];
    }
    return self;
}


/**
 *  查询照片(通过游记travelID)
 *
 *  @param travelRecord 游记记录
 *
 *  @return
 */
- (NSArray *)selectListByTravelRecord:(TravelRecord *)travelRecord{
    
    NSString *newSql =
    [NSString stringWithFormat:@"Select * from %@ where %@ = %@ order by %@ desc",
     _tableName, kPhotoNameKeyTravelID,travelRecord.travelID,kPhotoNameKeyCreateTime];
    NSArray * resultArry = [_photoTable findAllWithSQL:newSql params:nil error:nil];
    return resultArry;
}

/**
 *  插入(保存)照片
 *
 *  @param photoRecord 照片信息
 */
- (void)insertPhotoRecord:(PhotoRecord *)photoRecord{
    
    [_photoTable insertRecord:photoRecord error:nil];
}

@end
