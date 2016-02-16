//
//  SetController.h
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIView *safeView;
@property (weak, nonatomic) IBOutlet UIView *secretView;
@property (weak, nonatomic) IBOutlet UIView *remindView;
@property (weak, nonatomic) IBOutlet UIView *chatView;
@property (weak, nonatomic) IBOutlet UIView *cleanView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
