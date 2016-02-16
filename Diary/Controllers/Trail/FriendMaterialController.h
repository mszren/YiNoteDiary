//
//  FriendMaterialController.h
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendMaterialController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UIView *adressView;
@property (weak, nonatomic) IBOutlet UIView *qianmingView;

@property (weak, nonatomic) IBOutlet UIView *personPhotoView;

@property (weak, nonatomic) IBOutlet UIView *otherPhotoView;
@property (weak, nonatomic) IBOutlet UIView *otherQueueView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;


@end
