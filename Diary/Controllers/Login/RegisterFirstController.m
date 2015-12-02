//
//  RegisterFirstController.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "RegisterFirstController.h"

#import "Masonry.h"
#import "EGOImageView.h"
#import "DaiDodgeKeyboard.h"
#import "UzysAssetsPickerController.h"
#import "RegisterSecondController.h"

@interface RegisterFirstController () <UITextFieldDelegate,UzysAssetsPickerControllerDelegate>
@property (nonatomic,strong)UIButton *faceBtn;
@property (nonatomic,strong)UIButton *oldBtn;;
@property (nonatomic,strong)UITextField *nichengText;;
@property (nonatomic,strong)UITextField *addressText;;
@property (nonatomic,strong)UzysAssetsPickerController* picker;
@property (nonatomic,strong) NSMutableArray *arrImg;;
@property (nonatomic,strong)UIView *nichengView;
@property (nonatomic,strong)UIView *addressView;
@property (nonatomic,strong)EGOImageView *agreenImg;
@property (nonatomic,strong)UILabel *agreenLabel;

@end

@implementation RegisterFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self.view addSubview:self.faceBtn];
    [self.view addSubview:self.nichengView];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.agreenImg];
    [self.view addSubview:self.agreenLabel];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_nichengText resignFirstResponder];
    [_addressText resignFirstResponder];
    return YES;
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        [_arrImg addObjectsFromArray:assets];
        _faceBtn.layer.cornerRadius = 45;
        _faceBtn.clipsToBounds = YES;
        ALAsset* asset = assets[0];
        UIImage* tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [_faceBtn setImage:tempImg forState:UIControlStateNormal];
        
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    if (sender.tag == 100) {
        
        [_arrImg removeAllObjects];
        [self presentViewController:_picker
                           animated:YES
                         completion:^{
                             
                         }];
    }else{
        if (sender.tag != _oldBtn.tag) {
            
            UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
            button.selected = YES;
            button.backgroundColor = [UIColor greenColor];
            _oldBtn.selected = NO;
            _oldBtn.backgroundColor = [UIColor whiteColor];
            _oldBtn = button;
        }
    }
}

#pragma mark -- UIBarButtonItem Acyion
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    RegisterSecondController *registerSecondVc = [RegisterSecondController new];
    [self.navigationController pushViewController:registerSecondVc animated:YES];
}

- (void)initView{
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    self.title = @"注册1/3";
    self.view.backgroundColor = BGViewGray;
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 1;
    _picker.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(onRightBtn:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _oldBtn = (UIButton *)[self.view viewWithTag:200];
    _oldBtn.selected = YES;
    _oldBtn.backgroundColor = [UIColor greenColor];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    UIView *superView = self.view;
    
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(Screen_Width/2 - 45));
        make.top.mas_equalTo(superView.mas_top).offset(114);
        make.width.height.mas_equalTo(@90);
    }];
    
    [_nichengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_faceBtn.mas_bottom).offset(135);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_nichengText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nichengView.mas_left).offset(15);
        make.top.mas_equalTo(_nichengView.mas_top);
        make.width.mas_equalTo(@(Screen_Width - 30));
        make.height.mas_equalTo(@60);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_nichengView.mas_bottom).offset(10);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_addressView.mas_left).offset(15);
        make.top.mas_equalTo(_addressView.mas_top);
        make.width.mas_equalTo(@(Screen_Width - 30));
        make.height.mas_equalTo(@60);
    }];
    
    [_agreenImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(15);
        make.top.mas_equalTo(_addressView.mas_bottom).offset(15);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@17);
    }];
    
    [_agreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (_agreenImg.mas_right).offset(5);
        make.top.mas_equalTo(_addressView.mas_bottom).offset(15);
        make.width.mas_equalTo(@260);
        make.height.mas_equalTo(@13);
    }];
}

- (UIButton *)faceBtn{
    if (_faceBtn == nil) {
        _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceBtn.adjustsImageWhenHighlighted = NO;
        _faceBtn.tag = 100;
        _faceBtn.layer.shouldRasterize = YES;
        [_faceBtn setImage:[UIImage imageNamed:@"pic_bg"] forState:UIControlStateNormal];
        [_faceBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self sexBtn];
    }
    return _faceBtn;
}

- (UIView *)nichengView{
    if (_nichengView == nil) {
        _nichengView = [UIView new];
        _nichengView.backgroundColor = [UIColor whiteColor];
        [_nichengView addSubview:self.nichengText];
    }
    return _nichengView;
}

- (UITextField *)nichengText{
    if (_nichengText == nil) {
        _nichengText = [UITextField new];
        _nichengText.backgroundColor = [UIColor whiteColor];
        _nichengText.placeholder = @"昵称";
        _nichengText.font = [UIFont systemFontOfSize:15];
        _nichengText.delegate = self;
    }
    return _nichengText;
}

- (UIView *)addressView{
    if (_addressView == nil) {
        _addressView = [UIView new];
        _addressView.backgroundColor = [UIColor whiteColor];
        [_addressView addSubview:self.addressText];
    }
    return _addressView;
}

- (UITextField *)addressText{
    if (_addressText == nil) {
        _addressText = [UITextField new];
        _addressText.backgroundColor = [UIColor whiteColor];
        _addressText.placeholder = @"所在地";
        _addressText.font = [UIFont systemFontOfSize:15];
        _addressText.delegate = self;
    }
    return _addressText;
}

- (EGOImageView *)agreenImg{
    if (_agreenImg == nil) {
        _agreenImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
    }
    return _agreenImg;
}

- (UILabel *)agreenLabel{
    if (_agreenLabel == nil) {
        _agreenLabel = [UILabel new];
        _agreenLabel.text = @"点击下一步，表示同意《用户协议》";
        _agreenLabel.font = [UIFont systemFontOfSize:15];
    }
    return _agreenLabel;
}

- (void)sexBtn{
    
    NSArray *sexArry = @[@"帅哥",@"美女"];
    NSArray *nomalImgs = @[@"ic_xt_nan_normal",@"ic_xt_nv_normal"];
    NSArray *selectImgs = @[@"ic_xt_nan_selected",@"ic_xt_nv_selected"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((Screen_Width - 170)/3 + (85 + (Screen_Width - 170)/3)*i);
            make.top.mas_equalTo(self.view.mas_top).offset(229);
            make.width.mas_equalTo(@85);
            make.height.mas_equalTo(@30);
        }];
        [button setTitle:sexArry[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = 200 + i;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 10);
        button.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 15);
        [button setImage:[UIImage imageNamed:nomalImgs[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImgs[i]] forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (button.selected == NO) {
            button.backgroundColor = [UIColor whiteColor];
        }else{
            button.backgroundColor = [UIColor greenColor];
        }
        button.layer.cornerRadius = 15;
        button.clipsToBounds = YES;
        button.layer.shouldRasterize = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
