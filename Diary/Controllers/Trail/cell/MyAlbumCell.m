//
//  MyAlbumCell.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyAlbumCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

#define IMG_Width (Screen_Width - 80)/3

@interface MyAlbumCell ()
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *greenLabel;
@property (nonatomic, strong)EGOImageView *albumImg;

@end

@implementation MyAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BGViewColor;
        _greenLabel = [UILabel new];
        [self addSubview:_greenLabel];
        [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(23);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(@4);
            make.bottom.mas_equalTo(self);
        }];
        _greenLabel.backgroundColor = BGViewGreen;
        
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_greenLabel.mas_right).offset(25);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(@50);
            make.width.mas_equalTo(@180);
        }];
        _timeLabel.text = @"DAY1 2014年6月8日";
        _timeLabel.font = BOLDFont_SIZE_16;
        _timeLabel.textColor = BGViewGreen;
        
        for (NSInteger i = 0 ; i < 2; i++) {
            for (NSInteger j = 0; j < 3; j ++) {
                EGOImageView *img = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"img_saisai_hdzt2"]];
                [self addSubview:img];
                [img mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(_greenLabel.mas_right).offset(13 + (IMG_Width + 10)*j);
                    make.top.mas_equalTo(_timeLabel.mas_bottom).offset((IMG_Width + 10)*i);
                    make.width.height.mas_equalTo(@(IMG_Width));
                }];
            }
        }
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
