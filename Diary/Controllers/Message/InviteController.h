//
//  InviteController.h
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *qqView;
@property (weak, nonatomic) IBOutlet UIView *weichatView;
@property (weak, nonatomic) IBOutlet UIView *weiboView;
@property (weak, nonatomic) IBOutlet UIView *qqKoneView;
@property (weak, nonatomic) IBOutlet UIView *weichatKoneView;

@end
