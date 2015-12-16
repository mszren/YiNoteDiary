//
//  SelectAdressCell.m
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SelectAdressCell.h"
#import "Masonry.h"

@implementation SelectAdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor = BGViewColor;
    return self;
}

- (void)selectAderess:(NSInteger)selectIndex{
    
    [_addressImg setPlaceholderImage:[UIImage imageNamed:@"tabbar_home_selected"]];
}

- (void)initView{
    
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.addressImg];
    [self.contentView addSubview:self.grayLabel];
    
    UIView *contentView = self.contentView;
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).offset(13);
        make.top.height.mas_equalTo(contentView);
        make.width.mas_equalTo(@200);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentView.mas_right).offset(-13);
        make.top.mas_equalTo(contentView.mas_top).offset(19);
        make.height.width.mas_equalTo(@22);
    }];
    
    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.mas_equalTo(contentView);
        make.height.mas_equalTo(@0.5);
    }];
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel new];
        _addressLabel.text = @"平安银行";
        _addressLabel.font = FONT_SIZE_15;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_47;
    }
    return _addressLabel;
}

- (EGOImageView *)addressImg{
    if (_addressImg == nil) {
        _addressImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"tabbar_home_normal"]];
    }
    return _addressImg;
}

- (UILabel *)grayLabel{
    if (_grayLabel == nil) {
        _grayLabel = [UILabel new];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_153;
    }
    return _grayLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
