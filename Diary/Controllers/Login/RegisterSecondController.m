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
#import "BaseNavigation.h"
#import "CheckOutView.h"
#import "RemindView.h"

@interface RegisterSecondController () <CheckOutViewDelegate>
@property (nonatomic,strong)UIView *phoneView;
@property (nonatomic,strong) UITextField *phoneText;

@end

@implementation RegisterSecondController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view addSubview:self.phoneView];
}

#pragma mark -- CheckOutViewDelegate
- (void)certainJump{
    
    NSDictionary *dic= @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_REGISTER_3 withContext:dic];
}

#pragma mark -- UIBarButtonItem Acyion
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    [_phoneText resignFirstResponder];
    if ([Utils checkTelNumber:_phoneText.text]) {
        
        [self creatAlertController];
        
    }else{
        
        [[RemindView sharedInstance] showRemindView:@"请输入正确的手机号"];
    }
}

//创建提示选择框
- (void)creatAlertController{
    
    [[CheckOutView sharedInstance] showCheckOutView:@"确认手机号码" andRemind:[NSString stringWithFormat:@"我们将发送验证码到该手机:%@",_phoneText.text] andDelegate:self];

}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *superView = self.view;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"注册2/3"];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(40);
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
IMPLEMENT_MESSAGE_ROUTABLE


@end
