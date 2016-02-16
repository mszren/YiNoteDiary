//
//  TrailSetController.m
//  Diary
//
//  Created by 我 on 15/12/31.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TrailSetController.h"
#import "BaseNavigation.h"

@interface TrailSetController ()

@end

@implementation TrailSetController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
   
}

- (void)initView{
     self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.locationView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)]];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    NSDictionary *dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_LOCATIONBLACK withContext:dic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMPLEMENT_MESSAGE_ROUTABLE

@end
