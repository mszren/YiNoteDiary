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

@interface FindController ()

@end

@implementation FindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

- (void)initView{
    self.title = @"发现";
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
    [self.nearPictureView addGestureRecognizer:pictureTap];
    
    UITapGestureRecognizer *activityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nearActivityView addGestureRecognizer:activityTap];
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 100:{
            
            NearPersonController *personVc = [NearPersonController new];
            personVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personVc animated:YES];
        }
            break;
        case 101:{
            
            NearFeatureController *featureVc = [NearFeatureController new];
            featureVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:featureVc animated:YES];
        }
            
            break;
        case 102:
            
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
