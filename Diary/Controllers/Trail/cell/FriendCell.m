//
//  FriendCell.m
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FriendCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation FriendCell{
    EGOImageView *_faceImg;
    EGOImageView *_sexImg;
    UILabel *_nameLabel;
    UILabel *_addressLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(13);
            make.height.width.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_peoplenearby@3x"]];
        [self addSubview:_sexImg];
        [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_faceImg.mas_right);
            make.centerY.mas_equalTo(_faceImg.mas_top);
            make.width.height.mas_equalTo(@12);
        }];
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-12);
            make.top.mas_equalTo(self.mas_top).offset(15);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        _addressLabel.text = @"0.0米";
        _addressLabel.font = FONT_SIZE_13;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _addressLabel.textAlignment = NSTextAlignmentRight;
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(13);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@20);
        }];
        _nameLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _nameLabel.text = @"笨笨的我不懂你";
        _nameLabel.font = FONT_SIZE_15;
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_faceImg.mas_bottom).offset(13);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@0.5);
        }];
        grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_180;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
