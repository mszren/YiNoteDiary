//
//  RevordPasswordController.m
//  gaode
//
//  Created by 我 on 15/10/30.
//  Copyright © 2015年 我. All rights reserved.
//

#import "RevordPasswordController.h"
#import "Masonry.h"
#import "Utils.h"
#import "RevordPasswordSecondController.h"

@interface RevordPasswordController ()
@property (nonatomic,strong)UIView *phoneView;
@property (nonatomic,strong)UITextField *phoneText;

@end

@implementation RevordPasswordController

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

- (void)initView{
    
    self.title = @"重置密码";
    self.view.backgroundColor = BGViewGray;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//创建提示选择框
- (void)creatAlertController{
    
    UIAlertController*al=[UIAlertController alertControllerWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码到该手机:%@",_phoneText.text] preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        RevordPasswordSecondController *revordVc = [RevordPasswordSecondController new];
        [self.navigationController pushViewController:revordVc animated:YES];
        
    }]];
    
    [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }]];
    [self presentViewController:al animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
    UIView *superView = self.view;
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(104);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_phoneView.mas_left).offset(15);
        make.top.mas_equalTo(_phoneView.mas_top);
        make.width.mas_equalTo(@(SCREEN_WIDTH - 15));
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_phoneText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
