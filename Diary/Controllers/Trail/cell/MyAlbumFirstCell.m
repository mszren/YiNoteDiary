//
//  MyAlbumFirstCell.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyAlbumFirstCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

#define IMG_Width (Screen_Width - 80)/3

@interface MyAlbumFirstCell ()
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)EGOImageView *tagImg;
@property (nonatomic, strong)UILabel *greenLabel;
@property (nonatomic, strong)EGOImageView *albumImg;

@end

@implementation MyAlbumFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BGViewColor;
        _tagImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_nearbyattractions"]];
        [self addSubview:_tagImg];
        [_tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.height.width.mas_equalTo(@30);
        }];
        
        
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_tagImg.mas_right).offset(10);
            make.height.top.mas_equalTo(_tagImg);
            make.width.mas_equalTo(@180);
        }];
        _timeLabel.text = @"DAY1 2014年6月8日";
        _timeLabel.font = BOLDFont_SIZE_16;
        _timeLabel.textColor = BGViewGreen;
        
        for (NSInteger i = 0 ; i < 2; i++) {
            for (NSInteger j = 0; j < 3; j ++) {
                EGOImageView *img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
                [self addSubview:img];
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(_tagImg.mas_right).offset((IMG_Width + 10)*j);
                    make.top.mas_equalTo(_tagImg.mas_bottom).offset(20 + (IMG_Width + 10)*i);
                    make.width.height.mas_equalTo(@(IMG_Width));
                }];
            }
        }
        
        _greenLabel = [UILabel new];
        [self addSubview:_greenLabel];
        [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_tagImg);
            make.top.mas_equalTo(_tagImg.mas_bottom).offset(2);
            make.width.mas_equalTo(@4);
            make.bottom.mas_equalTo(self);
        }];
        _greenLabel.backgroundColor = BGViewGreen;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
