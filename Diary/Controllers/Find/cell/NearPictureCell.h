//
//  NearPictureCell.h
//  Diary
//
//  Created by 我 on 15/12/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface NearPictureCell : UICollectionViewCell
@property (nonatomic,strong)EGOImageView *pictureImg;

- (void)bindImg:(UIImage *)image;

@end
