//
//  CheckoutMessageView.h
//  Diary
//
//  Created by 我 on 15/12/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckoutMessageViewDelegate <NSObject>

- (void)CheckoutMessageView:(NSString *)message;

@end

@interface CheckoutMessageView : NSObject <UITextFieldDelegate>
@property (nonatomic,weak)id<CheckoutMessageViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UILabel *verticalLabel;
@property (nonatomic,strong)UITextField *passwordText;

+ (instancetype)sharedInstance;

- (void)showCheckoutMessageView:(NSString *)title andRemind:(NSString *)remind andDelegate:(id<CheckoutMessageViewDelegate>)delegate;

@end
