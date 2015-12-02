//
//  PersonCell.m
//  Diary
//
//  Created by 我 on 15/11/19.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PersonCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation PersonCell{
    
    EGOImageView *_titleImg;
    UILabel *_titleLabel;
    EGOImageView *_tapImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_peoplenearby@3x"]];
        [self addSubview:_titleImg];
        [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(13);
            make.width.height.mas_equalTo(@30);
        }];
        
        _titleLabel= [UILabel new];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleImg.mas_right).offset(13);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@56);
        }];
        _titleLabel.text = @"联系人";
        _titleLabel.font = FONT_SIZE_17;
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_153;
        
        _tapImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_arrow@3x"]];
        [self addSubview:_tapImg];
        [_tapImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-13);
            make.top.mas_equalTo(self.mas_top).offset(22);
            make.width.height.mas_equalTo(@12);
        }];
        
        UILabel *grayLabel = [UILabel new];
        [self addSubview:grayLabel];
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_titleImg.mas_bottom).offset(13);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@13);
        }];
        grayLabel.backgroundColor = BGViewGray;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
