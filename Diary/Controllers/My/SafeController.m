//
//  SafeController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SafeController.h"
#import "SafeView.h"
#import "BaseNavigation.h"

@interface SafeController () <SafeViewDelegate>

@end

@implementation SafeController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    UITapGestureRecognizer *editTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.editView addGestureRecognizer:editTap];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    [[SafeView sharedInstance] showSafeView:@"验证原密码" andRemind:@"为保证您的账户安全，修改密码前请输入原密码已验证" andDelegate:self];
}

#pragma mark -- SafeViewDelegate
- (void)safeView:(NSString *)password{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"账户安全"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE


@end
