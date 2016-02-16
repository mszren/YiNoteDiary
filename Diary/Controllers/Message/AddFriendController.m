//
//  AddFriendController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AddFriendController.h"
#import "InviteController.h"
#import "BaseNavigation.h"
#import "ScanController.h"

@interface AddFriendController ()

@end

@implementation AddFriendController
@synthesize messageListner;

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
        case 101:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_SCAN withContext:dic];
        }
            
            break;
        case 102:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_NEAR_PERSON withContext:dic];
        }
            
            break;
            
        default:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_INVITE withContext:dic];
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
IMPLEMENT_MESSAGE_ROUTABLE


@end
