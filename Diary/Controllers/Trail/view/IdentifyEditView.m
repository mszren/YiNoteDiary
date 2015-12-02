//
//  IdentifyEditView.m
//  Diary
//
//  Created by 我 on 15/11/18.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyEditView.h"
#import "Masonry.h"

@implementation IdentifyEditView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)showIdentifyEditView:(NSString *)context andDelegate:(id<IdentifyEditViewDelegate>)delegate{
    self.address = context;
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
        make.left.mas_equalTo(_viewController.view.mas_left);
        make.bottom.mas_equalTo(_viewController.view.mas_bottom);
        make.width.mas_equalTo(_viewController.view.mas_width);
        make.height.mas_equalTo(@200);
    }];
    _backGroundView.backgroundColor = BGViewGray;
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_backGroundView addGestureRecognizer:viewTap];
    _backGroundView.tag = 101;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(15);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@30);
    }];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = FONT_SIZE_17;
    [_cancelBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
    _cancelBtn.tag = 200;
    [_cancelBtn addTarget:self action:@selector(onInviteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backGroundView.mas_right);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(15);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@30);
    }];
    [_certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    _certainBtn.titleLabel.font = FONT_SIZE_17;
    [_certainBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
    _certainBtn.tag = 201;
    [_certainBtn addTarget:self action:@selector(onInviteBtn:) forControlEvents:UIControlEventTouchUpInside];
 
    _titleLabel = [UILabel new];
    [_backGroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(Screen_Width/2 - 40));
        make.top.mas_equalTo(_backGroundView.mas_top);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@80);
    }];
    _titleLabel.text = @"编辑描述";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = FONT_SIZE_17;
    _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
    
    _contentView = [UITextView new];
    [_backGroundView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(13);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.width.mas_equalTo(@(Screen_Width - 26));
        make.height.mas_equalTo(@120);
    }];
    _contentView.textColor = COLOR_GRAY_DEFAULT_133;
    _contentView.text = context;
    _contentView.font = FONT_SIZE_15;
    
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

#pragma mark -- UIButton Action
- (void)onInviteBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
            
            break;
            
        default:
            self.address = _contentView.text;
            break;
    }
    [self.delegate identifyEditView:self.address];
    [self clean];
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

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 0;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                self.window.alpha = 0;
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
                [self.window removeFromSuperview];
                [self.backGroundView removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
                [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
                
            }];
            
        }];
        
    });
}

@end
