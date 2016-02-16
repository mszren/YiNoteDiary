//
//  PersonCenterController.h
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UIView *nichengView;
 
@property (weak, nonatomic) IBOutlet UIView *signView;

@property (weak, nonatomic) IBOutlet UIView *sexView;

@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *adressView;
@property (weak, nonatomic) IBOutlet UIView *faceView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;
@end
