//
//  CommentView.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CommentView.h"
#import "Masonry.h"
#import "DaiDodgeKeyboard.h"

@implementation CommentView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)showCommentView:(id<CommentViewDelegate>)delegate{
    self.delegate = delegate;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_viewController.view];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 100;
    
    _backGroundView = [UIView new];
    [_viewController.view addSubview:_backGroundView];
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.left.mas_equalTo(_viewController.view);
        make.height.mas_equalTo(@50);
    }];
    _backGroundView.backgroundColor = BGViewGray;
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_backGroundView addGestureRecognizer:viewTap];
    _backGroundView.tag = 101;
    
    _commontText = [UITextField new];
    [_backGroundView addSubview:_commontText];
    [_commontText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(5);
        make.width.mas_equalTo(@(Screen_Width - 70));
        make.height.mas_equalTo(@40);
    }];
    _commontText.placeholder = @"请输入评论内容";
    _commontText.font = FONT_SIZE_15;
    _commontText.delegate = self;
    _commontText.borderStyle = UITextBorderStyleRoundedRect;
    
    _feelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_feelBtn];
    [_feelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backGroundView.mas_right).offset(-10);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(10);
        make.width.height.mas_equalTo(@30);
    }];
    [_feelBtn setImage:[UIImage imageNamed:@"ic_sweep the@3x"] forState:UIControlStateNormal];
    [_feelBtn addTarget:self action:@selector(onFeelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
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

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:
            [self clean];
            break;
            
        default:
            break;
    }
}

#pragma mark -- UIButton Action
- (void)onFeelBtn:(UIButton *)sender{
    [self.delegate commentViewReturn:_commontText.text];
    [_commontText resignFirstResponder];
    [self clean];
}

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.alpha = 0;
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            self.window.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            [self.window removeFromSuperview];
            [self.backGroundView removeFromSuperview];
            self.viewController = nil;
            self.window = nil;
            [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
            
        }];
        
    });
}

@end
