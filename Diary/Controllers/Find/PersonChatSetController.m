//
//  PersonChatSetController.m
//  Diary
//
//  Created by 我 on 15/12/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PersonChatSetController.h"
#import "BaseNavigation.h"

@interface PersonChatSetController ()

@end

@implementation PersonChatSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [_cleanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"所有聊天记录将会被删除，包括文字、语音、图片。确认删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"清除所有聊记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
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
