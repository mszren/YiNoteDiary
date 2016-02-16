//
//  FindController.m
//  Diary
//
//  Created by 我 on 15/11/27.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FindController.h"
#import "NearPersonController.h"
#import "NearFeatureController.h"
#import "BaseNavigation.h"
#import "NearPictureController.h"

@interface FindController ()

@end

@implementation FindController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = COLOR_GRAY_DEFAULT_240;
    
    self.nearPersonLabel.textColor = COLOR_GRAY_DEFAULT_153;
    self.nearFeatureLabel.textColor = COLOR_GRAY_DEFAULT_153;
    self.nearPictureLabel.textColor = COLOR_GRAY_DEFAULT_153;
    self.nearActivityLabel.textColor = COLOR_GRAY_DEFAULT_153;
    
    UITapGestureRecognizer *personTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearPersonView addGestureRecognizer:personTap];
    
    UITapGestureRecognizer *featureTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearFeatureView addGestureRecognizer:featureTap];
    
    UITapGestureRecognizer *pictureTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearPicVIew addGestureRecognizer:pictureTap];
    
    UITapGestureRecognizer *activityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearActivityView addGestureRecognizer:activityTap];
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 100:{
        
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_NEAR_PERSON withContext:dic];
            
        }
            break;
        case 101:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_NEAR_FEARTURE withContext:dic];
        }
            
            break;
        case 102:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_NEAR_PHOTO withContext:dic];
        }
            
            break;
            
        default:{
            
        }
            
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:@"发现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE
@end
