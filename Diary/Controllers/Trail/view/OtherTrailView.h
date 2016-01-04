//
//  OtherTrailView.h
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGOImageView.h"

@interface OtherTrailView : UIView
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)EGOImageView *faceImgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImage *faceImag;
@property (nonatomic,strong)NSString *nameStr;
@property (nonatomic,strong)NSString *contentStr;

- (void)setName:(NSString *)nameStr andContent:(NSString *)contentStr andImage:(UIImage *)faceImg;

@end
