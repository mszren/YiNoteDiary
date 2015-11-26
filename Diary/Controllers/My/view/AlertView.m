//
//  AlertView.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "AlertView.h"
#import "Masonry.h"

@implementation AlertView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showAlertView:(NSString *)title andMessage:(NSString *)content withDelegate:(id<AlertViewDelegate>)delegate{
    self.deletate = delegate;
    self.isCertain = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _viewController.view.tag = 200;
    
    _backGroundView = [UIView new];
     [_viewController.view addSubview:_backGroundView];
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.viewController.view.mas_left).offset(20);
        make.top.mas_equalTo(self.viewController.view.mas_top).offset(94);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(320.5);
    }];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 6;
    _backGroundView.clipsToBounds = YES;
    _backGroundView.layer.shouldRasterize = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_backGroundView addGestureRecognizer:backTap];
    
   
    _titleLabel = [UILabel new];
    [_backGroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.top.mas_equalTo(_backGroundView.mas_top);
        make.width.mas_equalTo(_backGroundView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    _titleLabel.text = title;
    _titleLabel.font = FONT_SIZE_27;
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _contentLabel = [UILabel new];
    [_backGroundView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(20);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(@60);
    }];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = content;
    _contentLabel.userInteractionEnabled = YES;
    _contentLabel.numberOfLines = 2;
    _contentLabel.font = FONT_SIZE_19;

    _passwordText = [UITextField new];
    [_backGroundView addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(@60);
    }];
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.font = FONT_SIZE_17;
    _passwordText.delegate = self;
    _passwordText.backgroundColor = BGViewGray;
    
    UILabel *grayLabel = [UILabel new];
    [_backGroundView addSubview:grayLabel];
    [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.top.mas_equalTo(_passwordText.mas_bottom).offset(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(@0.5);
    }];
    grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
    
    NSArray *arry = @[@"取消",@"确定"];
    for (NSInteger i = 0; i < arry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(0 + (SCREEN_WIDTH - 40)/2*i));
            make.top.mas_equalTo(grayLabel.mas_bottom);
            make.width.mas_equalTo((SCREEN_WIDTH - 40)/2);
            make.height.mas_equalTo(@60);
        }];
        [button setTitle:arry[i] forState:UIControlStateNormal];
        if (i == 0)
            [button setTitleColor:COLOR_GRAY_DEFAULT_185 forState:UIControlStateNormal];
        
        else
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        button.titleLabel.font = FONT_SIZE_27;
        button.tag = 100 + i;
        button.adjustsImageWhenHighlighted = NO;
        
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *verticalLabel = [UILabel new];
    [_backGroundView addSubview:verticalLabel];
    [verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 40)/2);
        make.top.mas_equalTo(grayLabel.mas_bottom);
        make.width.mas_equalTo(@0.5);
        make.height.mas_equalTo(@60);
    }];
    verticalLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
    
    // The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.window makeKeyAndVisible];
        
        _backGroundView.alpha = 0;
        _backGroundView.layer.shouldRasterize = YES;
        _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.alpha = 1;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {

            _backGroundView.layer.shouldRasterize = NO;
            
        }];
        
    });
    
    
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_passwordText resignFirstResponder];
    return YES;
}

#pragma  mark  -- UITapGestureRecognizer
-(void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 200:
            [self clean];
            break;
            
        default:
            break;
    }
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            self.isCertain = NO;
            break;
            
        default:
            self.isCertain = YES;
            break;
    }
    [self.deletate AlertViewDelegateIsCertain:self.isCertain];
    [self clean];
}

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            _viewController.view.alpha = 0;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [_passwordText resignFirstResponder];
            
        } completion:^(BOOL finished) {
            
            _backGroundView.alpha = 0;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            [self.window removeFromSuperview];
            [self.backGroundView removeFromSuperview];
            self.viewController = nil;
            self.window = nil;
            
        }];
        
    });
}

@end
