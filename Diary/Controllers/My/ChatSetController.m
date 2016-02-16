//
//  ChatSetController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ChatSetController.h"
#import "BaseNavigation.h"
#import "SPKitExample.h"

@interface ChatSetController ()

@end

@implementation ChatSetController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onCleanTap:)];
    [self.cleanView addGestureRecognizer:cleanTap];
}

#pragma mark -- UITapGestureRecognizer
- (void)onCleanTap:(UITapGestureRecognizer *)sender{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"所有聊天记录将会被删除，包括文字、语音、图片。确认删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"清除所有聊记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        id<IYWConversationService> conversationService = [[SPKitExample sharedInstance].ywIMKit.IMCore getConversationService];
        [conversationService asyncFetchAllConversationsWithCompletionBlock:^(NSArray *aConversationsArray) {
            
             [aConversationsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 YWConversation * conversation = obj;
                 
                 [conversationService removeConversationByConversationId:conversation.conversationId error:nil];
                 [conversation removeAllLocalMessages];
 
             }];
            [ToastManager showToast:@"清楚聊天记录成功" containerView:self.cleanView withTime:Toast_Hide_TIME];
        }];
        
 
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
IMPLEMENT_MESSAGE_ROUTABLE
 

@end
