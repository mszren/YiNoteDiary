//
//  SetController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SetController.h"
#import "BaseNavigation.h"

@interface SetController ()

@end

@implementation SetController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.infoView.frame.size.height + self.infoView.frame.origin.y);
    
    UITapGestureRecognizer *safeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.safeView addGestureRecognizer:safeTap];
    
    UITapGestureRecognizer *secretTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.secretView addGestureRecognizer:secretTap];
    
    UITapGestureRecognizer *remindTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.remindView addGestureRecognizer:remindTap];
    
    UITapGestureRecognizer *chatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.chatView addGestureRecognizer:chatTap];
    
    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.cleanView addGestureRecognizer:cleanTap];
    
    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.infoView addGestureRecognizer:infoTap];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 100:{
            
            NSDictionary * dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_SAFE withContext:dic];
        }
            
            break;
        case 101:{
            
            NSDictionary * dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_SECRET withContext:dic];
        }
            
            break;
        case 102:{
            
            NSDictionary * dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_REMIND withContext:dic];
        }
            
            break;
        case 103:{
            
            NSDictionary * dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_CAHTSET withContext:dic];
        }
            
            break;
        case 104:{
            
            [self creatAlertView];
        }
            
            break;
            
        default:
        {
            NSDictionary * dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_INFO withContext:dic];
        }
            break;
    }
}

- (void)creatAlertView{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"清除缓存后，包括语音、图片等多媒体消息需重新下载查看。确认清除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"清除所有聊记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
     [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMPLEMENT_MESSAGE_ROUTABLE

@end
