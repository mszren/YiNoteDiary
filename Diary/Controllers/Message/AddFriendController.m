//
//  AddFriendController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AddFriendController.h"
#import "NearPersonController.h"
#import "InviteController.h"
#import "BaseNavigation.h"

@interface AddFriendController ()

@end

@implementation AddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITapGestureRecognizer * nichengTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nichengView addGestureRecognizer:nichengTap];
    
    UITapGestureRecognizer * scanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.scanView addGestureRecognizer:scanTap];
    
    UITapGestureRecognizer * nearPersonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearPersonView addGestureRecognizer:nearPersonTap];
    
    UITapGestureRecognizer * inviteFriendTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.inviteFriendView addGestureRecognizer:inviteFriendTap];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:{
            
            NearPersonController *nearPersonVc = [NearPersonController new];
            nearPersonVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nearPersonVc animated:YES];
        }
            
            break;
            
        default:{
            
            InviteController *inviteVc = [InviteController new];
            inviteVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:inviteVc animated:YES];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"添加好友"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
