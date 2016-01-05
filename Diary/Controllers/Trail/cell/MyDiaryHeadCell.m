//
//  MyDiaryHeadCell.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyDiaryHeadCell.h"
#import "EGOImageView.h"
#import "Masonry.h"

@interface MyDiaryHeadCell ()

@property (nonatomic, strong)EGOImageView *trailImg;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation MyDiaryHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor = BGViewColor;
    return self;
}

- (void)initView{
    [self addSubview:self.trailImg];
    [self addSubview:self.titleLabel];
    
    [_trailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(13);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-13);
        make.height.mas_equalTo(@200);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_trailImg.mas_bottom).offset(30);
        make.height.mas_equalTo(@15);
    }];
}

- (EGOImageView *)trailImg{
    if (!_trailImg) {
        _trailImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        _trailImg.layer.cornerRadius = 6;
        _trailImg.clipsToBounds = YES;
        _trailImg.layer.shouldRasterize = YES;
    }
    return _trailImg;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"我的轨迹故事";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = BOLDFont_SIZE_16;
        _titleLabel.textColor = BGViewGreen;
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
