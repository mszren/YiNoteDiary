//
//  PictureSaveController.m
//  Diary
//
//  Created by 我 on 15/12/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PictureSaveController.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "UMSocial.h"
#import "ToastManager.h"

#define Kwidth 50
#define Kmargin (Screen_Width - 200)/8
@interface PictureSaveController () <UMSocialUIDelegate, UMSocialDataDelegate>
@property (nonatomic,strong) EGOImageView *saveImg;
@property (nonatomic,strong) UILabel *saveLabel;
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *weichatBtn;
@property (nonatomic,strong) UILabel *weichatLabel;
@property (nonatomic,strong) UIButton *qqKoneBtn;
@property (nonatomic,strong) UILabel *qqKoneLabel;
@property (nonatomic,strong) UIButton *sinaBtn;
@property (nonatomic,strong) UILabel *sinaLabel;
@property (nonatomic,strong) UIButton *qqBtn;
@property (nonatomic,strong) UILabel *qqLabel;
@property (nonatomic,strong) UIButton *returnBtn;

@end

@implementation PictureSaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
 
    self.view.backgroundColor = BGViewColor;
    [self.view addSubview:self.returnBtn];
    [self.view addSubview:self.saveImg];
    [self.view addSubview:self.saveLabel];
    [self.view addSubview:self.leftLabel];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.rightLabel];
    [self.view addSubview:self.weichatBtn];
    [self.view addSubview:self.weichatLabel];
    [self.view addSubview:self.qqKoneBtn];
    [self.view addSubview:self.qqKoneLabel];
    [self.view addSubview:self.sinaBtn];
    [self.view addSubview:self.sinaLabel];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.qqLabel];
    
    self.titleLabel.text = self.saveTitleStr;
}



#pragma mark-- UM
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity*)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if (response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@", [[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark -- UIButton Action
- (void)onShareBtn:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 100:{

            //微信邀请
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatSession ]
                                                               content:@"测试一下"
                                                                 image:[UIImage imageNamed:@"pic_bg"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {
                                                                
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
            
            
        }
            
            break;
            
        case 101:{
            
            //微信朋友圈
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatTimeline ]
                                                               content:@"家家帮里赚翻天！帮币冲抵更省钱"
                                                                 image:[UIImage imageNamed:@"108x108"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {
                                                                
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
            
        }
            
            break;
            
        case 102:{
            
            //微博邀请
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:[UIImage imageNamed:@"pic_bg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [ToastManager showToast:@"分享成功" withTime:Toast_Hide_TIME];
                }else{
                    [ToastManager showToast:@"分享失败" withTime:Toast_Hide_TIME];
                }
            }];
        }
            
            break;
            
        case 103:{
            
//            //QQ邀请
//            
//            [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//            [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:[UIImage imageNamed:@"pic_bg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }
//            }];
            
            [self updateView];

        }
            
            break;
    }
}

- (void)onBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//更新视图
- (void)updateView{
    [_saveImg removeFromSuperview];
    [_saveLabel removeFromSuperview];
    [_returnBtn setHidden:NO];
    
    UIView *superView = self.view;
    
    [_weichatLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-Screen_height/2);
        make.size.mas_equalTo(CGSizeMake(Kwidth, 20));
        make.left.mas_equalTo(superView.mas_left).offset(Kmargin);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    UIView *superView = self.view;
    
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-40);
        make.top.mas_equalTo(superView.mas_top).offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [_saveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView);
        make.top.mas_equalTo(superView.mas_top).offset(100);
        make.width.height.mas_equalTo(@110);
    }];
    
    [_saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_saveImg);
        make.top.mas_equalTo(_saveImg.mas_bottom).offset(10);
    }];
    
    [_weichatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(Kmargin);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-60);
        make.size.mas_equalTo(CGSizeMake(Kwidth, 20));
    }];
    
    [_weichatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_weichatLabel);
        make.bottom.mas_equalTo(_weichatLabel.mas_top).offset(-10);
        make.height.width.mas_equalTo(@(Kwidth));
    }];
    
    [_qqKoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatLabel);
        make.left.mas_equalTo(_weichatBtn.mas_right).offset(2*Kmargin);
    }];
    
    [_qqKoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatBtn);
        make.left.mas_equalTo(_weichatBtn.mas_right).offset(2*Kmargin);
    }];
    
    [_sinaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatLabel);
        make.left.mas_equalTo(_qqKoneLabel.mas_right).offset(2*Kmargin);
    }];
    
    [_sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatBtn);
        make.left.mas_equalTo(_qqKoneBtn.mas_right).offset(2*Kmargin);
    }];
    
    [_qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatLabel);
        make.left.mas_equalTo(_sinaLabel.mas_right).offset(2*Kmargin);
    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.mas_equalTo(_weichatBtn);
        make.left.mas_equalTo(_sinaBtn.mas_right).offset(2*Kmargin);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView);
        make.bottom.mas_equalTo(_weichatBtn.mas_top).offset(-50);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@180);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(40);
        make.right.mas_equalTo(_titleLabel.mas_left).offset(10);
        make.height.mas_equalTo(@0.5);
        make.centerY.mas_equalTo(_titleLabel);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-40);
        make.width.mas_equalTo(_leftLabel);
        make.height.mas_equalTo(@0.5);
        make.centerY.mas_equalTo(_titleLabel);
    }];
}

- (UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setTitle:@"完成" forState:UIControlStateNormal];
        _returnBtn.titleLabel.font = BOLDFont_SIZE_16;
        [_returnBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_returnBtn setHidden:YES];
        _returnBtn.adjustsImageWhenHighlighted = NO;
    }
    return _returnBtn;
}

- (EGOImageView *)saveImg{
    if (!_saveImg) {
        _saveImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_peoplenearby"]];
    }
    return _saveImg;
}

- (UILabel *)saveLabel{
    if (!_saveLabel) {
        _saveLabel = [UILabel new];
        _saveLabel.text = @"照片保存中";
        _saveLabel.font = BOLDFont_SIZE_16;
        _saveLabel.textAlignment = NSTextAlignmentCenter;
        _saveLabel.textColor = BGViewGreen;
    }
    return _saveLabel;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
    }
    return _leftLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = BOLDFont_SIZE_16;
        _titleLabel.text = @"把我的照片分享到";
    }
    return _titleLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
    }
    return _rightLabel;
}

- (UIButton *)weichatBtn{
    if (!_weichatBtn) {
        _weichatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weichatBtn.tag = 100;
        _weichatBtn.adjustsImageWhenHighlighted = NO;
        [_weichatBtn setBackgroundImage:[UIImage imageNamed:@"ic_activitiesnearby"] forState:UIControlStateNormal];
        [_weichatBtn addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weichatBtn;
}

- (UILabel *)weichatLabel{
    if (!_weichatLabel) {
        _weichatLabel = [UILabel new];
        _weichatLabel.textAlignment = NSTextAlignmentCenter;
        _weichatLabel.text = @"微信";
        _weichatLabel.font = BOLDFont_SIZE_14;
        _weichatLabel.textColor = COLOR_GRAY_DEFAULT_153;
    }
    return _weichatLabel;
}

- (UIButton *)qqKoneBtn{
    if (!_qqKoneBtn) {
        _qqKoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqKoneBtn.tag = 101;
        _qqKoneBtn.adjustsImageWhenHighlighted = NO;
        [_qqKoneBtn setBackgroundImage:[UIImage imageNamed:@"ic_nearbyattractions"] forState:UIControlStateNormal];
        [_qqKoneBtn addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqKoneBtn;
}

- (UILabel *)qqKoneLabel{
    if (!_qqKoneLabel) {
        _qqKoneLabel = [UILabel new];
        _qqKoneLabel.textAlignment = NSTextAlignmentCenter;
        _qqKoneLabel.text = @"朋友圈";
        _qqKoneLabel.font = BOLDFont_SIZE_14;
        _qqKoneLabel.textColor = COLOR_GRAY_DEFAULT_153;
    }
    return _qqKoneLabel;
}

- (UIButton *)sinaBtn{
    if (!_sinaBtn) {
        _sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sinaBtn.tag = 102;
        _sinaBtn.adjustsImageWhenHighlighted = NO;
        [_sinaBtn setBackgroundImage:[UIImage imageNamed:@"ic_nearphotos"] forState:UIControlStateNormal];
        [_sinaBtn addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sinaBtn;
}

- (UILabel *)sinaLabel{
    if (!_sinaLabel) {
        _sinaLabel = [UILabel new];
        _sinaLabel.textAlignment = NSTextAlignmentCenter;
        _sinaLabel.text = @"新浪";
        _sinaLabel.font = BOLDFont_SIZE_14;
        _sinaLabel.textColor = COLOR_GRAY_DEFAULT_153;
    }
    return _sinaLabel;
}

- (UIButton *)qqBtn{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _qqBtn.tag = 103;
        _qqBtn.adjustsImageWhenHighlighted = NO;
        [_qqBtn setBackgroundImage:[UIImage imageNamed:@"ic_peoplenearby"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(onShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

- (UILabel *)qqLabel{
    if (!_qqLabel) {
        _qqLabel = [UILabel new];
        _qqLabel.textAlignment = NSTextAlignmentCenter;
        _qqLabel.text = @"QQ好友";
        _qqLabel.font = BOLDFont_SIZE_14;
        _qqLabel.textColor = COLOR_GRAY_DEFAULT_153;
    }
    return _qqLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
