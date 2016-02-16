//
//  SexSelectController.h
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexSelectController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIView *manView;
@property (weak, nonatomic) IBOutlet UIImageView *manImg;
@property (weak, nonatomic) IBOutlet UIView *womanView;
@property (weak, nonatomic) IBOutlet UIImageView *womanImg;

@end
