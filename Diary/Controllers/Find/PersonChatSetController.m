//
//  PersonChatSetController.m
//  Diary
//
//  Created by 我 on 15/12/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PersonChatSetController.h"
#import "BaseNavigation.h"
#import "SPKitExample.h"

@interface PersonChatSetController ()

@end

@implementation PersonChatSetController{
    
    id<IYWSettingService> _iYWSettingService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    YWP2PConversation *conversation;
    _iYWSettingService = [[SPKitExample sharedInstance].ywIMKit.IMCore getSettingService];
    if ([_iYWSettingService getMessagePushEnableForPerson:conversation.person]) {
        
        [self.messageRemindSwitchBtn setOn:YES];
    }else
         [self.messageRemindSwitchBtn setOn:NO];
        
    
    [_cleanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    [self.chatSwitchBtn addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.messageRemindSwitchBtn addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark -- UISwitch Action
- (void)switchIsChanged:(UISwitch *)sender{
    YWP2PConversation *conversation;
    switch (sender.tag) {
        case 200:{
            
            if ([sender isOn])
                
                [conversation markConversationOnTop:YES getError:nil];
            else
                
                [conversation markConversationOnTop:NO getError:nil];
            
            break;
        }
            
        default:{
            
            if ([sender isOn]) {
            
//                [_iYWSettingService asyncSetMessagePushEnable:YES ForPerson:conversation.person completion:^(NSError *aError, NSDictionary *aResult) {
                
                    [ToastManager showToast:@"开启消息提醒" containerView:self.cleanView withTime:Toast_Hide_TIME];
//                }];
              
            }else{
                
//                [_iYWSettingService asyncSetMessagePushEnable:NO ForPerson:conversation.person completion:^(NSError *aError, NSDictionary *aResult) {
                
                    [ToastManager showToast:@"关闭消息提醒" containerView:self.cleanView withTime:Toast_Hide_TIME];
//                }];
            }
        }
            
            break;
    }
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"所有聊天记录将会被删除，包括文字、语音、图片。确认删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"清除所有聊记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        YWConversation * conversation;
        [conversation removeAllLocalMessages];
    
     [ToastManager showToast:@"清除聊天记录成功" containerView:self.cleanView withTime:Toast_Hide_TIME];
     
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"聊天设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
