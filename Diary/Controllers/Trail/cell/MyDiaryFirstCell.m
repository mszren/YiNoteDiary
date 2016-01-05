//
//  MyDiaryFirstCell.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyDiaryFirstCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@interface MyDiaryFirstCell ()
@property (nonatomic, strong)EGOImageView *tagImg;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)EGOImageView *trailImg;
@property (nonatomic, strong)UILabel *greenLabel;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UILabel *descripeLabel;
@property (nonatomic, strong)EGOImageView *timeImg;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)EGOImageView *addressImg;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UIView *backGroundView;

@end

@implementation MyDiaryFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    self.backgroundColor = COLOR_GRAY_DEFAULT_240;
    return self;
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    
}

- (void)initView{
    
    [self.contentView addSubview:self.backGroundView];
    
    UIView *superView = self.contentView;
    
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(13);
        make.top.mas_equalTo(superView.mas_top).offset(2);
        make.right.mas_equalTo(superView.mas_right).offset(-13);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-2);
    }];
    
    [_tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(_backGroundView);
        make.height.width.mas_equalTo(@30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tagImg.mas_right).offset(13);
        make.top.height.mas_equalTo(_tagImg);
        make.width.mas_equalTo(@200);
    }];
    
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_tagImg);
        make.top.mas_equalTo(_tagImg.mas_bottom).offset(2);
        make.width.mas_equalTo(@4);
        make.height.mas_equalTo(@10);
    }];
    
    [_trailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(_backGroundView);
        make.top.mas_equalTo(_greenLabel.mas_bottom);
        make.height.mas_equalTo(@200);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_trailImg.mas_right).offset(-13);
        make.top.mas_equalTo(_trailImg.mas_top).offset(13);
        make.height.width.mas_equalTo(@30);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_editBtn.mas_left).offset(-20);
        make.top.mas_equalTo(_editBtn);
        make.height.width.mas_equalTo(@30);
    }];
    
    [_descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(13);
        make.top.mas_equalTo(_trailImg.mas_bottom).offset(10);
        make.right.mas_equalTo(_backGroundView.mas_right).offset(-13);
    }];
    
    [_timeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left).offset(13);
        make.top.mas_equalTo(_descripeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.bottom.mas_equalTo(_backGroundView.mas_bottom).offset(-13);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeImg.mas_right).offset(5);
        make.top.height.mas_equalTo(_timeImg);
        make.width.mas_equalTo(@120);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeLabel.mas_right).offset(40);
        make.top.width.height.mas_equalTo(_timeImg);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_addressImg.mas_right).offset(5);
        make.height.top.mas_equalTo(_timeLabel);
    }];
}

- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [UIView new];
        _backGroundView.backgroundColor = BGViewColor;
        [_backGroundView addSubview:self.tagImg];
        [_backGroundView addSubview:self.titleLabel];
        [_backGroundView addSubview:self.greenLabel];
        [_backGroundView addSubview:self.trailImg];
        [_backGroundView addSubview:self.descripeLabel];
        [_backGroundView addSubview:self.timeImg];
        [_backGroundView addSubview:self.timeLabel];
        [_backGroundView addSubview:self.addressImg];
        [_backGroundView addSubview:self.addressLabel];
    }
    return _backGroundView;
}

- (EGOImageView *)tagImg{
    if (!_tagImg) {
        _tagImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_nearbyattractions"]];
    }
    return _tagImg;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = BOLDFont_SIZE_15;
        _titleLabel.textColor = BGViewGreen;
        _titleLabel.text = @"DAY1 2014年6月";
    }
    return _titleLabel;
}

- (UILabel *)greenLabel{
    if (!_greenLabel) {
        _greenLabel = [UILabel new];
        _greenLabel.backgroundColor = BGViewGreen;
    }
    return _greenLabel;
}

- (EGOImageView *)trailImg{
    if (!_trailImg) {
        _trailImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        _trailImg.layer.cornerRadius = 6;
        _trailImg.clipsToBounds = YES;
        _trailImg.layer.shouldRasterize = YES;
        [_trailImg addSubview:self.editBtn];
        [_trailImg addSubview:self.deleteBtn];
    }
    return _trailImg;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_aSet up"] forState:UIControlStateNormal];
        _deleteBtn.tag = 100;
        [_deleteBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.adjustsImageWhenHighlighted = NO;
        [_editBtn setImage:[UIImage imageNamed:@"ic_aSet up"] forState:UIControlStateNormal];
        _editBtn.tag = 101;
        [_editBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (UILabel *)descripeLabel{
    if (!_descripeLabel) {
        _descripeLabel = [UILabel new];
        _descripeLabel.numberOfLines = 0;
        _descripeLabel.text = @"行走在美丽的中国行走在美丽的中国行走在美丽的中国行走在美丽的中国行走在美丽的中国.";
        _descripeLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _descripeLabel.font = FONT_SIZE_13;
    }
    return _descripeLabel;
}

- (EGOImageView *)timeImg{
    if (!_timeImg) {
        _timeImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_review"]];
    }
    return _timeImg;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _timeLabel.font = FONT_SIZE_13;
        _timeLabel.text = @"2014-06-08  09:30";
    }
    return _timeLabel;
}

- (EGOImageView *)addressImg{
    if (!_addressImg) {
        _addressImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_landmark"]];
    }
    return _addressImg;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _addressLabel.font = FONT_SIZE_13;
        _addressLabel.text = @"上海东方明珠";
    }
    return _addressLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
