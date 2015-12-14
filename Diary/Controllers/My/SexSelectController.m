//
//  SexSelectController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SexSelectController.h"
#import "BaseNavigation.h"

@interface SexSelectController ()

@end

@implementation SexSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
     [BaseNavigation setGreenNavigationBar:self andTitle:@"性别"];
    [self initView];
}

- (void)initView{
    
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
