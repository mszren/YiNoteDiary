//
//  AlbumHeadCell.m
//  Diary
//
//  Created by 我 on 15/11/13.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AlbumHeadCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation AlbumHeadCell{
    EGOImageView *_titleImg;
    UILabel *_titleLabel;
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
        _titleLabel.text = @"最热专辑欣赏";
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _titleLabel.font = FONT_SIZE_17;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
