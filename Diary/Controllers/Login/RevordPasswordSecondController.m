//
//  RevordPasswordSecondController.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved
//

#import "RevordPasswordSecondController.h"
#import "Utils.h"
#import "Masonry.h"
#import "BaseNavigation.h"

@interface RevordPasswordSecondController () <UITextFieldDelegate>
@property (nonatomic,strong)UIView *phoneView;
@property (nonatomic,strong)UITextField *cardText;
@property (nonatomic,strong)UITextField *password;
@property (nonatomic,strong)UIView *passwordView;

@end

@implementation RevordPasswordSecondController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view addSubview:self.passwordView];
    [self.view addSubview:self.phoneView];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_password resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _password) {
        
#pragma 判断是否是数字或字母
        return [Utils checNumAndLetter:string];
    }else {
        
        if (range.location > 5) {
            UIAlertController*al=[UIAlertController alertControllerWithTitle:nil message:@"验证码只有6位" preferredStyle:UIAlertControllerStyleAlert];
            [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:al animated:YES completion:nil];
            
            return NO;
        }
        return YES;
    }
    
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
}

- (void)initView{
    
    self.view.backgroundColor = BGViewGray;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[BaseNavigation sharedInstance]setGreenNavigationBar:self andTitle:@"重置密码"];
    UIView *superView = self.view;
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(40);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_cardText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(15);
        make.top.mas_equalTo(_phoneView.mas_top);
        make.width.mas_equalTo(@(Screen_Width - 15));
        make.height.mas_equalTo(@60);
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_phoneView.mas_bottom).offset(10);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_passwordView.mas_left).offset(15);
        make.top.mas_equalTo(_passwordView.mas_top);
        make.width.mas_equalTo(@(Screen_Width - 15));
        make.height.mas_equalTo(@60);
    }];
}

- (UIView *)phoneView{
    if (_phoneView == nil) {
        _phoneView = [UIView new];
        _phoneView.backgroundColor = BGViewColor;
        [_phoneView addSubview:self.cardText];
    }
    return _phoneView;
}

- (UITextField *)cardText{
    if (_cardText == nil) {
        _cardText = [UITextField new];
        _cardText.placeholder = @"验证码";
        _cardText.delegate = self;
        _cardText.font = [UIFont systemFontOfSize:15];
        _cardText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardText;
}

- (UIView *)passwordView{
    if (_passwordView == nil) {
        _passwordView = [UIView new];
        _passwordView.backgroundColor = BGViewColor;
        [_passwordView addSubview:self.password];
    }
    return _passwordView;
}

- (UITextField *)password{
    if (_password == nil) {
        _password = [UITextField new];
        _password.placeholder = @"密码";
        _password.delegate = self;
        _password.keyboardType = UIKeyboardTypeASCIICapable;
        _password.font = [UIFont systemFontOfSize:15];
    }
    return _password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE


@end
