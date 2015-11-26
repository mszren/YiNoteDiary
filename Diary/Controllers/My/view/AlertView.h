//
//  AlertView.h
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>
- (void)AlertViewDelegateIsCertain:(BOOL)isCertain;


@end
@interface AlertView : NSObject  <UITextFieldDelegate>
@property (nonatomic,weak)id<AlertViewDelegate>deletate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UITextField *passwordText;
@property (nonatomic,assign)BOOL isCertain;


+ (instancetype)sharedInstance;

- (void)showAlertView:(NSString *)title andMessage:(NSString *)content withDelegate:(id<AlertViewDelegate>)delegate;

@end
