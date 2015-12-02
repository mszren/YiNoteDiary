//
//  FindController.h
//  Diary
//
//  Created by 我 on 15/11/27.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *nearPersonView;
@property (weak, nonatomic) IBOutlet UILabel *nearPersonLabel;
@property (weak, nonatomic) IBOutlet UIView *nearFeatureView;
@property (weak, nonatomic) IBOutlet UILabel *nearFeatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nearPictureView;
@property (weak, nonatomic) IBOutlet UILabel *nearPictureLabel;
@property (weak, nonatomic) IBOutlet UIView *nearActivityView;
@property (weak, nonatomic) IBOutlet UILabel *nearActivityLabel;

@end
