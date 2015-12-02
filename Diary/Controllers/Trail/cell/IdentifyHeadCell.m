//
//  IdentifyHeadCell.m
//  Diary
//
//  Created by 我 on 15/11/25.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyHeadCell.h"
#import "Masonry.h"

@implementation IdentifyHeadCell{
    UILabel *_titleLabel;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@40);
        }];
        _titleLabel.textColor= COLOR_GRAY_DEFAULT_47;
        _titleLabel.text = @"请选择位置";
        _titleLabel.font = FONT_SIZE_17;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_titleLabel.mas_bottom);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_180;
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
