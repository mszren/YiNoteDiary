//
//  SecretController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SecretController.h"
#import "BaseNavigation.h"

@interface SecretController ()

@end

@implementation SecretController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.areaBlackAdressView.frame.size.height + self.areaBlackAdressView.frame.origin.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"隐私"];
}


@end
