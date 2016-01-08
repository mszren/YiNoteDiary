//
//  EditDiaryController.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "EditDiaryController.h"
#import "BaseNavigation.h"
#import "EGOImageView.h"
#import "Masonry.h"
#import "DaiDodgeKeyboard.h"
#import "PictureSaveController.h"

@interface EditDiaryController () <UITextViewDelegate>
@property (nonatomic, strong)EGOImageView *trailImg;
@property (nonatomic, strong)UITextView *editView;
@property (nonatomic, strong)UILabel *coverLabel;
@property (nonatomic, strong)UIView *backGroundView;

@end

@implementation EditDiaryController{
    UIBarButtonItem* _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = COLOR_GRAY_DEFAULT_240;
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_aSet up"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    [self.view addSubview:self.backGroundView];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView*)textView
{
    _editView.text = textView.text;
    if (_editView.text.length == 0) {
        _coverLabel.text = @"把你想说的话写下来...";
    }
    else {
        _coverLabel.text = @"";
    }
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_editView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    PictureSaveController *pictureSaveVc = [PictureSaveController new];
    pictureSaveVc.hidesBottomBarWhenPushed = YES;
    pictureSaveVc.saveTitleStr = @"专辑保存中";
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:pictureSaveVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"编辑我的故事"];
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    
    UIView *superView = self.view;
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(superView.mas_top).offset(1);
        make.height.mas_equalTo(@343);
    }];
    
    [_trailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(13);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(13);
        make.right.mas_equalTo(_backGroundView.mas_right).offset(-13);
        make.height.mas_equalTo(@200);
    }];
    
    [_editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(13);
        make.top.mas_equalTo(_trailImg.mas_bottom).offset(20);
        make.right.mas_equalTo(_backGroundView.mas_right).offset(-13);
        make.height.mas_equalTo(@80);
    }];
 
    [_coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_editView.mas_left).offset(7);
        make.top.mas_equalTo(_editView.mas_top).offset(9);
        make.size.mas_equalTo(CGSizeMake(150, 13));
    }];
}

- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [UIView new];
        _backGroundView.backgroundColor = BGViewColor;
        [_backGroundView addSubview:self.trailImg];
        [_backGroundView addSubview:self.editView];
    }
    return _backGroundView;
}

- (EGOImageView *)trailImg{
    if(!_trailImg){
        _trailImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
    }
    return _trailImg;
}

- (UITextView *)editView{
    if (!_editView) {
        _editView = [UITextView new];
        _editView.textColor = BGViewGreen;
        _editView.font = FONT_SIZE_13;
        _editView.delegate = self;
        _editView.layer.borderWidth = 2;
        _editView.layer.borderColor = BGViewGreen.CGColor;
        _editView.layer.cornerRadius = 4;
        _editView.clipsToBounds = YES;
        _editView.layer.shouldRasterize = YES;
        [_editView addSubview:self.coverLabel];
    }
    return _editView;
}

- (UILabel *)coverLabel{
    if (!_coverLabel) {
        _coverLabel = [UILabel new];
        _coverLabel.text = @"把你想说的话写下来...";
        _coverLabel.textColor = BGViewGreen;
        _coverLabel.font = FONT_SIZE_13;
    }
    return _coverLabel;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
