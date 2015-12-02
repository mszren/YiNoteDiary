//
//  SafeView.h
//  Diary
//
//  Created by 我 on 15/12/1.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SafeViewDelegate <NSObject>

- (void)safeView:(NSString *)password;

@end

@interface SafeView : NSObject <UITextFieldDelegate>
@property (nonatomic,weak)id<SafeViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *grayLabel;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UILabel *verticalLabel;
@property (nonatomic,strong)UITextField *passwordText;

+ (instancetype)sharedInstance;

- (void)showSafeView:(NSString *)title andRemind:(NSString *)remind andDelegate:(id<SafeViewDelegate>)delegate;

@end
