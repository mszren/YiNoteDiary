//
//  CommentView.h
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommentViewDelegate <NSObject>

- (void)commentViewReturn:(NSString *)content;

@end

@interface CommentView : NSObject <UITextFieldDelegate>
@property (nonatomic,weak)id<CommentViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UITextField *commontText;
@property (nonatomic,strong)UIButton *feelBtn;

+ (instancetype)sharedInstance;

- (void)showCommentView:(id<CommentViewDelegate>)delegate;

@end
