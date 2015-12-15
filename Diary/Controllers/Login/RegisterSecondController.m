//
//  RegisterSecondController.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "RegisterSecondController.h"
#import "Masonry.h"
#import "Utils.h"
#import "RegisterThirdController.h"
#import "BaseNavigation.h"

@interface RegisterSecondController ()
@property (nonatomic,strong)UIView *phoneView;
@property (nonatomic,strong) UITextField *phoneText;

@end

@implementation RegisterSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view addSubview:self.phoneView];
}

#pragma mark -- UIBarButtonItem Acyion
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    [_phoneText resignFirstResponder];
    if ([Utils checkTelNumber:_phoneText.text]) {
        
        [self creatAlertController];
        
    }else{
        UIAlertController*al=[UIAlertController alertControllerWithTitle:nil message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:al animated:YES completion:nil];
    }
}

//创建提示选择框
- (void)creatAlertController{
    
    UIAlertController*al=[UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码到该手机:%@",_phoneText.text] preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        RegisterThirdController *thirdVc = [RegisterThirdController new];
        [self.navigationController pushViewController:thirdVc animated:YES];
    }]];
    
    [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }]];
    [self presentViewController:al animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *superView = self.view;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"注册2/3"];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(104);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_phoneView.mas_left).offset(15);
        make.top.mas_equalTo(_phoneView.mas_top);
        make.width.mas_equalTo(@(Screen_Width - 15));
        make.height.mas_equalTo(@60);
    }];
}

- (UIView *)phoneView{
    if (_phoneView == nil) {
        _phoneView = [UIView new];
        _phoneView.backgroundColor = BGViewColor;
        [_phoneView addSubview:self.phoneText];
    }
    return _phoneView;
}

- (UITextField *)phoneText{
    if (_phoneText == nil) {
        _phoneText = [UITextField new];
        _phoneText.placeholder = @"请输入手机号";
        _phoneText.font = [UIFont systemFontOfSize:15];
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneText;
}

- (void)initView{
    
    self.view.backgroundColor = BGViewGray;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [_phoneText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
