//
//  IndexDetailHeadView.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IndexDetailHeadView.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation IndexDetailHeadView{
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UIButton *_addBtn;
    UILabel *_titleLabel;
    EGOImageView *_contentImg;
    UIButton *_addressBtn;
    UILabel *_addressLabel;
    UIButton *_praiseBtn;
    UILabel *_preiseLabel;
    UIButton *_commentBtn;
    UILabel *_commentLabel;
    UIButton *_attentionBtn;
    UILabel *_attentionLabel;
    UIView *_backGroundView;
}

- (id)init{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, Screen_Width, 354);
        self.backgroundColor = BGViewGray;
        
        _backGroundView = [UIView new];
        [self addSubview:_backGroundView];
        [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(self.mas_top).offset(13);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@331);
        }];
        _backGroundView.backgroundColor = BGViewColor;
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [_backGroundView addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
            make.top.mas_equalTo(_backGroundView.mas_top).offset(10);
            make.width.height.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _nameLabel = [UILabel new];
        [_backGroundView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@20);
        }];
        _nameLabel.text = @"行走的袋鼠";
        _nameLabel.font = FONT_SIZE_16;
        _nameLabel.textColor = COLOR_GRAY_DEFAULT_47;
        
        _timeLabel = [UILabel new];
        [_backGroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@20);
        }];
        _timeLabel.text = @"53分钟前";
        _timeLabel.font = FONT_SIZE_13;
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_133;
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_backGroundView.mas_right).offset(-20);
            make.top.mas_equalTo(_backGroundView.mas_top).offset(20);
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(@30);
        }];
        [_addBtn setTitle:@"好友" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = FONT_SIZE_14;
        
        _titleLabel = [UILabel new];
        [_backGroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(_faceImg.mas_bottom).offset(10);
            make.width.mas_equalTo(@250);
            make.height.mas_equalTo(@20);
        }];
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _titleLabel.text = @"美丽神秘的丽江之行";
        _titleLabel.font = FONT_SIZE_15;
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [_backGroundView addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(@(Screen_Width - 20));
            make.height.mas_equalTo(@200);
        }];
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_addressBtn];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
            make.top.mas_equalTo(_contentImg.mas_bottom).offset(11);
            make.width.height.mas_equalTo(@20);
        }];
        [_addressBtn setImage:[UIImage imageNamed:@"ic_landmark@3x"] forState:UIControlStateNormal];
        
        _addressLabel = [UILabel new];
        [_backGroundView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_addressBtn.mas_right).offset(5);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        _addressLabel.text = @"云南-丽江";
        _addressLabel.font = FONT_SIZE_15;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_180;
        
        _attentionLabel = [UILabel new];
        [_backGroundView addSubview:_attentionLabel];
        [_attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_backGroundView.mas_right).offset(-10);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _attentionLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _attentionLabel.text = @"1.6万";
        _attentionLabel.font = FONT_SIZE_11;
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_attentionLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_attentionLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_attentionBtn setImage:[UIImage imageNamed:@"ic_browse@3x"] forState:UIControlStateNormal];
        
        _commentLabel = [UILabel new];
        [_backGroundView addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_attentionBtn.mas_right).offset(-20);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _commentLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _commentLabel.text = @"8";
        _commentLabel.font = FONT_SIZE_11;
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_commentLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_review@3x"] forState:UIControlStateNormal];
        
        _preiseLabel = [UILabel new];
        [_backGroundView addSubview:_preiseLabel];
        [_preiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentBtn.mas_right).offset(-20);
            make.top.mas_equalTo(_commentBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _preiseLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _preiseLabel.text = @"14";
        _preiseLabel.font = FONT_SIZE_11;
        
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_praiseBtn];
        [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_preiseLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_preiseLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_praiseBtn setImage:[UIImage imageNamed:@"ic_like@3x"] forState:UIControlStateNormal];
    }
    return self;
}

@end
