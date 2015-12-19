//
//  ChatAssistanceView.h
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayPageControl.h"

@protocol ChatAssistanceViewDelegate <NSObject>

- (void)selectResult:(id)sendMessage;

@end

@interface ChatAssistanceView : UIView
@property (nonatomic, weak)id<ChatAssistanceViewDelegate>delegate;
@property (nonatomic, strong) UIViewController* currentVc;

@end
