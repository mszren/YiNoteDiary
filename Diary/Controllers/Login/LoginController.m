//
//  LoginByPhoneController.m
//  Diary
//
//  Created by Owen on 15/10/29.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LoginController.h"
#import "LDNetworking.h"
#import "Masonry.h"
#import "UserBusinessManager.h"
#import "ErrorReformer.h"

@interface LoginController()<UITextFieldDelegate,
LDAPIManagerParamSourceDelegate>
@property(nonatomic, strong) UserBusinessManager *userBusinessManager;
@property(nonatomic, strong) LDAPIBaseManager *loginByWeiboManager;
@property(nonatomic,strong) id<LDAPIManagerCallbackDataReformer> dataReformer;
@property(nonatomic, strong) UITextField *txtUserName;
@property(nonatomic, strong) UITextField *txtPassword;
@property(nonatomic, strong) UIButton *btnLogin;
@property(nonatomic, strong) UIButton *btnRegister;
@property(nonatomic, strong) UIButton *btnForgetPwd;
@property(nonatomic, strong) UIImageView *ivWeiChat;
@property(nonatomic, strong) UIImageView *ivQQ;
@property(nonatomic, strong) UIImageView *ivWeibo;
@end

@implementation LoginController


#pragma mark -
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = BGViewGray;
    self.title = @"登录";
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.txtPassword];
    [self.view addSubview:self.btnLogin];
    [self.view addSubview:self.btnRegister];
    [self.view addSubview:self.btnForgetPwd];
    [self.view addSubview:self.ivQQ];
    [self.view addSubview:self.ivWeiChat];
    [self.view addSubview:self.ivWeibo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *superView = self.view;

    [_txtUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(150);
        make.width.equalTo(superView.mas_width);
        make.left.equalTo(superView.mas_left);
        make.height.equalTo(@30);
    }];
    [_txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtUserName.mas_bottom).offset(10);
        make.width.equalTo(superView.mas_width);
        make.left.equalTo(superView.mas_left);
        make.height.equalTo(@30);
    }];
    [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtPassword.mas_bottom).offset(10);
        make.width.equalTo(superView.mas_width).offset(-20);
        make.left.equalTo(superView.mas_left).offset(10);
        make.height.equalTo(@30);
    }];
    
    [_btnForgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnLogin.mas_bottom);
        make.width.equalTo(@70);
        make.right.equalTo(superView.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
    
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
        make.width.equalTo(@70);
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@30);
    }];
    
    [_ivQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnForgetPwd.mas_bottom).offset(50);
        make.width.height.equalTo(@50);
        make.centerX.equalTo(superView.mas_centerX);
        
    }];
    
    [_ivWeiChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnForgetPwd.mas_bottom).offset(50);
        make.width.height.equalTo(@50);
        make.right.equalTo(_ivQQ.mas_left).offset(-50);
        
    }];
    
    [_ivWeibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btnForgetPwd.mas_bottom).offset(50);
        make.width.height.equalTo(@50);
        make.left.equalTo(_ivQQ.mas_right).offset(50);
        
    }];
}

#pragma mark -
#pragma mark event response
- (void)loginBtnAction:(id)sender {
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];

    [self.userBusinessManager login:self];
    
}

- (void)registerBtnAction:(id)sender {
//    RegisterController *controller = [[RegisterController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)forgetBtnAction:(id)sender {
//    ForgetPwdController *controller = [[ForgetPwdController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loginByQQ:(id)sender {
//    UMSocialSnsPlatform *snsPlatform =
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    
//    snsPlatform.loginClickHandler(
//                                  self, [UMSocialControllerService defaultControllerService], YES,
//                                  ^(UMSocialResponseEntity *response) {
//                                      
//                                      //          获取微博用户名、uid、token等
//                                      if (response.responseCode == UMSResponseCodeSuccess) {
//                                          
//                                          UMSocialAccountEntity *snsAccount =
//                                          [[UMSocialAccountManager socialAccountDictionary]
//                                           valueForKey:UMShareToSina];
//                                          [UMSocialAccountManager setSnsAccount:snsAccount];
//                                          accoutEntity = snsAccount;
//                                          NSLog(@"username is %@, uid is %@, token is %@ url is %@",
//                                                snsAccount.userName, snsAccount.usid, snsAccount.accessToken,
//                                                snsAccount.iconURL);
//                                          [self.loginByWeiboManager loadData];
//                                      }
//                                  });
}


#pragma mark - LDAPIManagerApiCallBackDelegate
- (NSDictionary *)paramsForApi:(LDAPIBaseManager *)manager {
        return @{
                 @"username" : _txtUserName.text,
                 @"password" : _txtPassword.text
                 };
    

}

#pragma mark - getters and setters
- (UserBusinessManager *)userBusinessManager {
    if (_userBusinessManager == nil) {
        _userBusinessManager = [UserBusinessManager sharedInstance];
    }
    return _userBusinessManager;
}


- (UITextField *)txtUserName {
    if (_txtUserName == nil) {
        _txtUserName = [[UITextField alloc] init];
        _txtUserName.backgroundColor = [UIColor whiteColor];
        _txtUserName.delegate = self;
        _txtUserName.font = [UIFont systemFontOfSize:13];
        _txtUserName.placeholder = @"请输入帐号";
    }
    return _txtUserName;
}

- (UITextField *)txtPassword {
    if (_txtPassword == nil) {
        _txtPassword = [[UITextField alloc] init];
        _txtPassword.backgroundColor = [UIColor whiteColor];
        _txtPassword.font = [UIFont systemFontOfSize:13];
        _txtPassword.delegate = self;
        _txtPassword.placeholder = @"请输入密码";
    }
    return _txtPassword;
}

- (UIButton *)btnLogin {
    if (_btnLogin == nil) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin addTarget:self
                      action:@selector(loginBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [_btnLogin setTitleColor:[UIColor whiteColor]
                        forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:16];
        _btnLogin.backgroundColor = [UIColor orangeColor];
    }
    return _btnLogin;
}

- (UIButton *)btnRegister {
    if (_btnRegister == nil) {
        _btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRegister setTitle:@"帐号注册" forState:UIControlStateNormal];
        [_btnRegister setTitleColor:COLOR_GRAY_DEFAULT_30
                           forState:UIControlStateNormal];
        _btnRegister.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRegister addTarget:self
                         action:@selector(registerBtnAction:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRegister;
}
- (UIButton *)btnForgetPwd {
    if (_btnForgetPwd == nil) {
        _btnForgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnForgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _btnForgetPwd.titleLabel.font = [UIFont systemFontOfSize:13];
        _btnForgetPwd.titleLabel.textAlignment = NSTextAlignmentRight;
        [_btnForgetPwd setTitleColor:COLOR_GRAY_DEFAULT_185
                            forState:UIControlStateNormal];
        [_btnForgetPwd addTarget:self
                          action:@selector(forgetBtnAction:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnForgetPwd;
}

- (UIImageView *)ivWeibo {
    if (_ivWeibo == nil) {
        _ivWeibo = [[UIImageView alloc]
                    initWithImage:[UIImage imageNamed:@"btn_weibo_login"]];
    }
    return _ivWeibo;
}

- (UIImageView *)ivQQ {
    if (_ivQQ == nil) {
        _ivQQ = [[UIImageView alloc]
                 initWithImage:[UIImage imageNamed:@"btn_qq_login"]];
        _ivQQ.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(loginByQQ:)];
        [_ivQQ addGestureRecognizer:tapGesture];
    }
    return _ivQQ;
}

- (UIImageView *)ivWeiChat {
    if (_ivWeiChat == nil) {
        _ivWeiChat = [[UIImageView alloc]
                      initWithImage:[UIImage imageNamed:@"btn_weixin_login"]];
    }
    return _ivWeiChat;
}
@end