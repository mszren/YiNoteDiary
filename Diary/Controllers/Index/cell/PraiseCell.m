//
//  PraiseCell.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PraiseCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation PraiseCell{
    EGOImageView *_faceImg;
    EGOImageView *_sexImg;
    UILabel *_nameLabel;
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
            make.top.mas_equalTo(self.mas_top).offset(23);
            make.width.height.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_share@2x"]];
        [self addSubview:_sexImg];
        [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_faceImg.mas_right);
            make.centerY.mas_equalTo(_faceImg.mas_top);
            make.width.height.mas_equalTo(@10);
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(20);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.size.mas_equalTo(CGSizeMake(200, 40));
        }];
        _nameLabel.text = @"任晋宇";
        _nameLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _nameLabel.font = FONT_SIZE_17;
        
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@200);
            make.height.mas_equalTo(@40);
        }];
        _timeLabel.text = @"15分钟前";
        _timeLabel.font = FONT_SIZE_13;
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(_faceImg.mas_bottom).offset(13);
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_133;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
