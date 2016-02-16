//
//  EditController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "EditController.h"
#import "BaseNavigation.h"

@interface EditController () <UITextFieldDelegate>

@end

@implementation EditController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.editText.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.editText resignFirstResponder];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"昵称"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE


- (IBAction)onCleanBtn:(UIButton *)sender {
    self.editText.text = nil;
}
@end
