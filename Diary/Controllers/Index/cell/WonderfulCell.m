//
//  WonderfulCell.m
//  Diary
//
//  Created by 我 on 15/11/13.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "WonderfulCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation WonderfulCell{
    
    EGOImageView *_titleImg;
    UILabel *_titleLabel;
    EGOImageView *_firstImg;
    EGOImageView *_secondImg;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_albums@3x"]];
        [self addSubview:_titleImg];
        [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.height.mas_equalTo(@30);
        }];
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleImg.mas_right).offset(10);
            make.top.mas_equalTo(_titleImg.mas_top);
            make.width.mas_equalTo(@200);
            make.height.mas_equalTo(@30);
        }];
        _titleLabel.text = @"发现每日精彩";
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _titleLabel.font = FONT_SIZE_17;
        
        _firstImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_firstImg];
        [_firstImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(_titleImg.mas_bottom).offset(10);
            make.width.mas_equalTo(@((Screen_Width - 30)/2));
            make.height.mas_equalTo(@80);
        }];
        _firstImg.layer.cornerRadius = 4;
        _firstImg.clipsToBounds = YES;
        _firstImg.layer.shouldRasterize = YES;
        
        _secondImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_secondImg];
        [_secondImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_firstImg.mas_right).offset(10);
            make.top.mas_equalTo(_firstImg.mas_top);
            make.width.mas_equalTo(@((Screen_Width - 30)/2));
            make.height.mas_equalTo(@80);
        }];
        _secondImg.layer.cornerRadius = 4;
        _secondImg.clipsToBounds = YES;
        _secondImg.layer.shouldRasterize = YES;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_firstImg.mas_bottom).offset(10);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@10);
        }];
        _grayLabel.backgroundColor = BGViewGray;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
