//
//  IndexCommentView.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IndexCommentView.h"
#import "Masonry.h"


@implementation IndexCommentView{
    UILabel *_grayLabel;
    UILabel *_verticalLabel1;
    UILabel *_verticalLabel2;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BGViewColor;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.mas_equalTo(self);
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = BGViewGray;
        
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_praiseBtn];
        [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_grayLabel.mas_bottom);
            make.width.mas_equalTo(@(Screen_Width/3));
            make.height.mas_equalTo(@40);
        }];
        [_praiseBtn setImage:[UIImage imageNamed:@"ic_like@3x"] forState:UIControlStateNormal];
        [_praiseBtn setTitle:@"14" forState:UIControlStateNormal];
        _praiseBtn.titleLabel.font = FONT_SIZE_13;
        [_praiseBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
        _praiseBtn.backgroundColor = BGViewColor;
        _praiseBtn.tag = 100;
        _praiseBtn.adjustsImageWhenHighlighted = NO;
        _praiseBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 10);
        _praiseBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 5);
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_praiseBtn.mas_right);
            make.top.width.height.mas_equalTo(_praiseBtn);
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_review@3x"] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"8" forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = FONT_SIZE_13;
        [_commentBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
        _commentBtn.backgroundColor = BGViewColor;
        _commentBtn.tag = 101;
        _commentBtn.adjustsImageWhenHighlighted = NO;
        _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 10);
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 5);
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_commentBtn.mas_right);
            make.top.width.height.mas_equalTo(_praiseBtn);
        }];
        [_shareBtn setImage:[UIImage imageNamed:@"ic_review@3x"] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = FONT_SIZE_13;
        [_shareBtn setTitleColor:COLOR_GRAY_DEFAULT_133 forState:UIControlStateNormal];
        _shareBtn.backgroundColor = BGViewColor;
        _shareBtn.tag = 102;
        _shareBtn.adjustsImageWhenHighlighted = NO;
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 5, 10, 10);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 5);
        
        _verticalLabel1 = [UILabel new];
        [_praiseBtn addSubview:_verticalLabel1];
        [_verticalLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_praiseBtn.mas_right);
            make.top.mas_equalTo(_praiseBtn.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(1, 20));
        }];
        _verticalLabel1.backgroundColor = BGViewGray;
        
        _verticalLabel2 = [UILabel new];
        [_commentBtn addSubview:_verticalLabel2];
        [_verticalLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentBtn.mas_right);
            make.top.mas_equalTo(_commentBtn.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(1, 20));
        }];
        _verticalLabel2.backgroundColor = BGViewGray;
    }
    return self;
}

@end
