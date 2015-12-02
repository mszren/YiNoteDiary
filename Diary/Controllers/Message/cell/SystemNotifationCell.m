//
//  SysytemNotifationCell.m
//  Diary
//
//  Created by 我 on 15/11/19.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SystemNotifationCell.h"
#import "EGOImageView.h"
#import "Masonry.h"

@implementation SysytemNotifationCell{
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.height.mas_equalTo(@60);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@30);
        }];
        _nameLabel.text = @"密柚miyou";
        _nameLabel.font = FONT_SIZE_13;
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@30);
        }];
        _titleLabel.text = @"清凉夏日塞班岛7日游";
        _titleLabel.font = FONT_SIZE_13;
        
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@20);
        }];
        _timeLabel.text = @"2015-12-10";
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = FONT_SIZE_11;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_faceImg.mas_bottom).offset(10);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
