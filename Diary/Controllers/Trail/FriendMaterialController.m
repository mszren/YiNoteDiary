//
//  FriendMaterialController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FriendMaterialController.h"
#import "BaseNavigation.h"

@interface FriendMaterialController ()

@end

@implementation FriendMaterialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [BaseNavigation setGreenNavigationBar:self andTitle:@"详细资料"];
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.messageBtn.frame.size.height + self.messageBtn.frame.origin.y + 10);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
