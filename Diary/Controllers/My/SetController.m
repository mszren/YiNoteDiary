//
//  SetController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SetController.h"
#import "SafeController.h"
#import "SecretController.h"
#import "RemindSetController.h"
#import "ChatSetController.h"
#import "InforController.h"

@interface SetController ()

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.title = @"设置";
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
            
            SafeController *safeVc = [SafeController new];
            safeVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:safeVc animated:YES];
        }
            
            break;
        case 101:{
            
            SecretController *secretSetVc = [SecretController new];
            secretSetVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:secretSetVc animated:YES];
        }
            
            break;
        case 102:{
            
            RemindSetController *remindVc = [RemindSetController new];
            remindVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:remindVc animated:YES];
        }
            
            break;
        case 103:{
            
            ChatSetController *chatSetVc = [ChatSetController new];
            chatSetVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatSetVc animated:YES];
        }
            
            break;
        case 104:{
            
            [self creatAlertView];
        }
            
            break;
            
        default:
        {
            InfoController *infoVc = [InfoController new];
            infoVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:infoVc animated:YES];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
