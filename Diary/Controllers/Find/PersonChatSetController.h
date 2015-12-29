//
//  PersonChatSetController.h
//  Diary
//
//  Created by 我 on 15/12/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonChatSetController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UIView *faceView;
@property (weak, nonatomic) IBOutlet UISwitch *chatSwitchBtn;
@property (weak, nonatomic) IBOutlet UISwitch *messageRemindSwitchBtn;
@property (weak, nonatomic) IBOutlet UIView *cleanView;
@property (weak, nonatomic) IBOutlet UIView *informerView;

@end
