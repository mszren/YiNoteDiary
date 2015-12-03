//
//  CommentCell.m
//  Diary
//
//  Created by 我 on 15/12/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CommentCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@implementation CommentCell{
    EGOImageView *_faceImg;
    EGOImageView *_sexImg;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_commentLabel;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.width.height.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_share@2x"]];
        [self addSubview:_sexImg];
        [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_faceImg.mas_right);
            make.centerY.mas_equalTo(_faceImg.mas_top);
            make.width.height.mas_equalTo(@10);
        }];
        
        _nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(20);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        _nameLabel.text = @"MR_mistake";
        _nameLabel.textColor = [UIColor greenColor];
        _nameLabel.font = FONT_SIZE_13;
        
        _timeLabel = [UILabel new];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@20);
        }];
        _timeLabel.text = @"15分钟前";
        _timeLabel.font = FONT_SIZE_11;
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        _commentLabel = [UILabel new];
        [self addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(20);
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.width.mas_equalTo(@160);
            make.height.mas_equalTo(@50);
        }];
        _commentLabel.numberOfLines = 2;
        NSString *commentString = @"回复327_破钟:虚伪的人，说出这种漂亮的话";
        NSInteger length = commentString.length;
        NSMutableAttributedString *attriButedString = [[NSMutableAttributedString alloc]initWithString:commentString];
        [attriButedString  addAttribute:NSFontAttributeName value:FONT_SIZE_13 range:NSMakeRange(0, length)];
        [attriButedString addAttribute:NSForegroundColorAttributeName value:COLOR_GRAY_DEFAULT_47 range:NSMakeRange(0, length)];
        [attriButedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:[commentString rangeOfString:@"327_破钟"]];
        _commentLabel.attributedText = attriButedString;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(_commentLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(@0.5);
        }];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_133;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
