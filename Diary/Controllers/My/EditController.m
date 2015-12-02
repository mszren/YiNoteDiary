//
//  EditController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "EditController.h"

@interface EditController () <UITextFieldDelegate>

@end

@implementation EditController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.title = @"昵称";
    self.editText.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.editText resignFirstResponder];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onCleanBtn:(UIButton *)sender {
    self.editText.text = nil;
}
@end
