//
//  RemindSetController.h
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindSetController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *messageSwich;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shakeSwitch;

@end
