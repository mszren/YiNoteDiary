//
//  RemindSetController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "RemindSetController.h"
#import "BaseNavigation.h"

@interface RemindSetController ()

@end

@implementation RemindSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BaseNavigation setGreenNavigationBar:self andTitle:@"提醒设置"];
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
