//
//  QueueView.h
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGOImageView.h"

@interface QueueView : NSObject
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)EGOImageView *faceImg;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *inviteBtn;
@property (nonatomic,strong)UIViewController *baseViewController;

+ (instancetype)sharedInstance;

- (void)showQueueView:(NSString *)name andTitle:(NSString *)title withViewController:(UIViewController *)viewController;
@end
