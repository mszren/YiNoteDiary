//
//  PhotoModel.h
//  Common
//
//  Created by Owen on 15/8/2.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : DBManager
@property(nonatomic, strong) NSString *photoID;
@property(nonatomic, strong) NSString *viewspotID;
@property(nonatomic, strong) NSString *photoName;
@property(nonatomic, strong) NSString *photoURL;
@property(nonatomic, strong) NSString *photoLocalPath;
@property(nonatomic, assign) NSTimeInterval createTime;

- (void)insertWithModel:(PhotoModel *)aModel;
@end
