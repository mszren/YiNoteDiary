//
//  IdentifyDetailCell.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyDetailCell.h"
#import "Masonry.h"

@implementation IdentifyDetailCell{
    UILabel *_titleLabel;
    UILabel *_locationLabel;
    UILabel *_addressLabel;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@15);
        }];
        _titleLabel.text = @"国际购物中心";
        _titleLabel.font = FONT_SIZE_15;
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
        
        _locationLabel = [UILabel new];
        [self addSubview:_locationLabel];
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-13);
            make.top.mas_equalTo(self.mas_top).offset(15);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@20);
        }];
        _locationLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _locationLabel.textAlignment = NSTextAlignmentRight;
        _locationLabel.text = @"31.19243,121.54044";
        _locationLabel.font = FONT_SIZE_13;
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(13);
            make.width.mas_equalTo(@(Screen_Width - 80));
            make.height.mas_equalTo(@40);
        }];
        _addressLabel.numberOfLines = 2;
        _addressLabel.text = @"北京市朝阳区工人体育场北路购物广场服务商城；购物中心";
        _addressLabel.font = FONT_SIZE_13;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_133;
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_addressLabel.mas_bottom).offset(13);
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
