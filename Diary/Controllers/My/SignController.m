//
//  SignController.m
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SignController.h"
#import "Masonry.h"

@interface SignController () <UITextViewDelegate>
@property (nonatomic,strong)UITextView *signText;
@property (nonatomic,strong)UILabel *coverLabel;
@property (nonatomic,strong)UILabel *countLabel;

@end

@implementation SignController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.title = @"个性签名";
    self.view.backgroundColor = BGViewGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.signText];
    [self.view addSubview:self.countLabel];
}

#pragma mark-- UITextViewDelegate
- (void)textViewDidChange:(UITextView*)textView
{
    _signText.text = textView.text;
    if (_signText.text.length == 0) {
        _coverLabel.text = @"个性签名应该签什么呢?";
    }
    else {
        _coverLabel.text = @"";
    }
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if (range.location > 29) {
        UIAlertController  *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"个性签名不能超过30位" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVc animated:YES completion:nil];
        
        return NO;
    }else{
        
        if ([text isEqualToString:@"\n"]) {
            
            _countLabel.text = [NSString stringWithFormat:@"还可以输入%lu个字",
                                60 - _signText.text.length];
            [_signText resignFirstResponder];
            return NO;
        }
        
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *superView = self.view;
    
    [_signText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.mas_equalTo(superView);
        make.height.mas_equalTo(@120);
    }];
    
    [_coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_signText.mas_left).offset(7);
        make.top.mas_equalTo(_signText.mas_top).offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-7);
        make.top.mas_equalTo(_signText.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}

- (UITextView *)signText{
    if (_signText == nil) {
        _signText = [UITextView new];
        _signText.font = FONT_SIZE_15;
        [_signText addSubview:self.coverLabel];
        _signText.delegate = self;
    }
    return _signText;
}

- (UILabel *)coverLabel{
    if (_coverLabel == nil) {
        _coverLabel = [UILabel new];
        _coverLabel.text = @"个性签名应该签什么呢?";
        _coverLabel.font = FONT_SIZE_15;
        _coverLabel.textColor = COLOR_GRAY_DEFAULT_153;
    }
    return _coverLabel;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [UILabel new];
        _countLabel.text = @"0/30";
        _countLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _countLabel.font = FONT_SIZE_15;
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
