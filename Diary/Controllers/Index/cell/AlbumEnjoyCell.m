//
//  AlbumEnjoyCell.m
//  Diary
//
//  Created by 我 on 15/11/13.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AlbumEnjoyCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation AlbumEnjoyCell{
    EGOImageView *_contentImg;
    UILabel *_titleLabel;
    UILabel *_verticalLabel;
    UILabel *_timeLabel;
    UILabel *_dayLbel;
    UILabel *_scanLabel;
    UILabel *_addressLabel;
    
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(Screen_Width - 20);
            make.height.mas_equalTo(@200);
        }];
        _contentImg.layer.cornerRadius = 4;
        _contentImg.clipsToBounds = YES;
        _contentImg.layer.shouldRasterize = YES;
        
        _titleLabel = [UILabel new];
        [_contentImg addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contentImg.mas_left).offset(10);
            make.top.mas_equalTo(_contentImg.mas_top).offset(10);
            make.width.mas_equalTo(@300);
            make.height.mas_equalTo(@30);
        }];
        _titleLabel.textColor = BGViewColor;
        _titleLabel.text = @"非常爱妮--最后的净土@巴拉望";
        _titleLabel.font = FONT_SIZE_20;
        
        _verticalLabel = [UILabel new];
        [_contentImg addSubview:_verticalLabel];
        [_verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contentImg.mas_left).offset(10);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(@3);
            make.height.mas_equalTo(@30);
        }];
        _verticalLabel.backgroundColor = [UIColor greenColor];
        
        _timeLabel = [UILabel new];
        [_contentImg addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_verticalLabel.mas_right).offset(5);
            make.top.mas_equalTo(_verticalLabel.mas_top);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@15);
        }];
        _timeLabel.text = @"2015.07.08";
        _timeLabel.font = FONT_SIZE_11;
        _timeLabel.textColor = BGViewColor;
        
        _dayLbel = [UILabel new];
        [_contentImg addSubview:_dayLbel];
        [_dayLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_timeLabel.mas_right).offset(10);
            make.top.mas_equalTo(_verticalLabel.mas_top);
            make.width.mas_equalTo(@20);
            make.height.mas_equalTo(@15);
        }];
        _dayLbel.text = @"6天";
        _dayLbel.font = FONT_SIZE_11;
        _dayLbel.textColor = BGViewColor;
        
        
        _scanLabel = [UILabel new];
        [_contentImg addSubview:_scanLabel];
        [_scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_dayLbel.mas_right).offset(10);
            make.top.mas_equalTo(_verticalLabel.mas_top);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@15);
        }];
        _scanLabel.text = @"1633 浏览";
        _scanLabel.font = FONT_SIZE_11;
        _scanLabel.textColor = BGViewColor;
        
        _addressLabel = [UILabel new];
        [_contentImg addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_verticalLabel.mas_right).offset(5);
            make.top.mas_equalTo(_timeLabel.mas_bottom);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@15);
        }];
        _addressLabel.text = @"菲律宾，康塞普西翁";
        _addressLabel.font = FONT_SIZE_11;
        _addressLabel.textColor = BGViewColor;
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_share@2x"]];
        [_contentImg addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contentImg.mas_left).offset(10);
            make.bottom.mas_equalTo(_contentImg.mas_bottom).offset(-20);
            make.width.height.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = _faceImg.frame.size.width/2;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _nameLabel = [UILabel new];
        [_contentImg addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(5);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@40);
        }];
        _nameLabel.textColor = BGViewColor;
        _nameLabel.text = @"by Asenath";
        _nameLabel.font = FONT_SIZE_13;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
