//
//  CodeController.m
//  Diary
//
//  Created by 我 on 15/11/24.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CodeController.h"
#import "BaseNavigation.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface CodeController ()
@property (nonatomic,strong) MPMoviePlayerController *player;;

@end

@implementation CodeController{
    UIBarButtonItem* _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self paly];
}

- (void)initView{

    self.view.backgroundColor = BGViewColor;
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    [self creatAlertView];
}

- (void)creatAlertView{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"分享二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)paly{
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
//    _player = [[MPMoviePlayerController alloc]initWithContentURL:url];
//    _player.view.frame = CGRectMake(0, 100, Screen_Width, 200);
//    _player.controlStyle = MPMovieControlStyleDefault;
//    _player.shouldAutoplay = NO;
//    [_player prepareToPlay];
//    [self.view addSubview:_player.view];
    
}

-(void)exitFullScreen:(NSNotification *)notification{
    [_player.view removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"二维码名片"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
