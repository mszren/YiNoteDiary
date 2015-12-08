//
//  QueueView.m
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "QueueView.h"
#import "Masonry.h"
#import "FriendListController.h"

@implementation QueueView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)showQueueView:(NSString *)name andTitle:(NSString *)title withViewController:(UIViewController *)viewController{
    self.baseViewController = viewController;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_viewController.view addGestureRecognizer:tap];
    _viewController.view.tag = 100;
    
    _backGroundView = [UIView new];
    [_viewController.view addSubview:_backGroundView];
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_viewController.view.mas_left);
        make.bottom.mas_equalTo(_viewController.view.mas_bottom);
        make.width.mas_equalTo(_viewController.view.mas_width);
        make.height.mas_equalTo(@330);
    }];
    _backGroundView.backgroundColor = BGViewColor;
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [_backGroundView addGestureRecognizer:viewTap];
    _backGroundView.tag = 101;
   
    _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
    [_backGroundView addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(Screen_Width/2 - 40));
        make.top.mas_equalTo(_backGroundView.mas_top).offset(20);
        make.width.height.mas_equalTo(@80);
    }];
    _faceImg.layer.cornerRadius = 40;
    _faceImg.clipsToBounds = YES;
    _faceImg.layer.shouldRasterize = YES;
    
    _nameLabel = [UILabel new];
    [_backGroundView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.top.mas_equalTo(_faceImg.mas_bottom).offset(5);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(@20);
    }];
    _nameLabel.text = name;
    _nameLabel.textColor = COLOR_GRAY_DEFAULT_133;
    _nameLabel.font = FONT_SIZE_15;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel = [UILabel new];
    [_backGroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(50);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(@(Screen_Width - 100));
        make.height.mas_equalTo(@50);
    }];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = title;
    _titleLabel.font = FONT_SIZE_17;
    _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
    _titleLabel.numberOfLines = 2;
    
    UIView *orangView = [UIView new];
    [_backGroundView addSubview:orangView];
    [orangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.bottom.mas_equalTo(_backGroundView.mas_bottom);
        make.width.mas_equalTo(_backGroundView.mas_width);
        make.height.mas_equalTo(@70);
    }];
    orangView.backgroundColor = [UIColor orangeColor];
    
    _inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orangView addSubview:_inviteBtn];
    [_inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(Screen_Width/2 - 60));
        make.top.mas_equalTo(orangView.mas_top).offset(20);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(@30);
    }];
    [_inviteBtn setTitle:@"发起邀请" forState:UIControlStateNormal];
    [_inviteBtn setTitleColor:BGViewColor forState:UIControlStateNormal];
    _inviteBtn.titleLabel.font = FONT_SIZE_17;
    _inviteBtn.layer.cornerRadius = 15;
    _inviteBtn.clipsToBounds = YES;
    _inviteBtn.layer.shouldRasterize = YES;
    _inviteBtn.layer.borderWidth = 2;
    _inviteBtn.layer.borderColor = BGViewColor.CGColor;
    [_inviteBtn addTarget:self action:@selector(onInviteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
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
- (void)onInviteBtn{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"附近的人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"我的好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        [self clean];
        FriendListController *friendVc = [FriendListController new];
        friendVc.hidesBottomBarWhenPushed = YES;
        [self.baseViewController.navigationController pushViewController:friendVc animated:YES];
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [_viewController presentViewController:alertVc animated:YES completion:nil];
    
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
                
                
            }];
            
        }];
        
    });
}

@end
