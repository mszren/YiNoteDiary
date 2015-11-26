//
//  IdentifyDetailCell.m
//  Diary
//
//  Created by 我 on 15/11/18.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyDetailCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation IdentifyDetailCell{
    
    UILabel *_destinationLabel;
    UILabel *_titleLabel;
    UILabel *_locationLabel;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@15);
        }];
        _titleLabel.text = @"国际购物中心";
        _titleLabel.font = FONT_SIZE_15;
        
        _locationLabel = [UILabel new];
        [self addSubview:_locationLabel];
        [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@15);
        }];
        _locationLabel.text = @"31.19243,121.54044";
        _locationLabel.font = FONT_SIZE_13;
        _locationLabel.textAlignment = NSTextAlignmentRight;
        
        _destinationLabel = [UILabel new];
        [self addSubview:_destinationLabel];
        [_destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
            make.width.mas_equalTo(@(SCREEN_WIDTH - 55));
            make.height.mas_equalTo(40);
        }];
        _destinationLabel.numberOfLines = 0;
        _destinationLabel.text = @"北京市朝阳区工人体育场北路购物服务商城;购物中心";
        _destinationLabel.font = FONT_SIZE_13;
        _destinationLabel.textColor = COLOR_GRAY_DEFAULT_153;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_destinationLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_185;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
