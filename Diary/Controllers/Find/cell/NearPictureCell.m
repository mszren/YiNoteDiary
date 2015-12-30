//
//  NearPictureCell.m
//  Diary
//
//  Created by 我 on 15/12/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "NearPictureCell.h"


@implementation NearPictureCell

- (instancetype)init{
    self = [super init];
    if (self) {
        _pictureImg = [[EGOImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_pictureImg];
    }
    return self;
}

- (void)bindImg:(UIImage *)image{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    _pictureImg = [[EGOImageView alloc]initWithFrame:self.bounds];
    [self addSubview:_pictureImg];

    _pictureImg.image = image;
}

@end
