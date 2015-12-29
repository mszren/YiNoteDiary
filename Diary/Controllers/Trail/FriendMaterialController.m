//
//  FriendMaterialController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FriendMaterialController.h"
#import "BaseNavigation.h"
#import "CheckoutMessageView.h"
#import "ChatToolController.h"
#import "PersonChatSetController.h"

@interface FriendMaterialController () <CheckoutMessageViewDelegate>

@end

@implementation FriendMaterialController{
    
    UIBarButtonItem* _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
   
}

- (void)initView{
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.messageBtn.frame.size.height + self.messageBtn.frame.origin.y + 10);
    
    [_addFriendBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_messageBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- CheckoutMessageViewDelegate
- (void)CheckoutMessageView:(NSString *)message{
    
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    PersonChatSetController *chatVc = [PersonChatSetController new];
    chatVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVc animated:YES];
}

- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
        {
           [[CheckoutMessageView sharedInstance] showCheckoutMessageView:@"验证信息" andRemind:@"请输入验证信息" andDelegate:self];
        }
            break;
            
        default:{
            
            ChatToolController *chatToolVc = [ChatToolController new];
            chatToolVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatToolVc animated:YES];
        }
            break;
    }
}

 

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"详细资料"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
