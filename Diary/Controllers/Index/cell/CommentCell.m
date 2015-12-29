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

@interface CommentCell()
@property (nonatomic,strong) EGOImageView *faceImg;
@property (nonatomic,strong) EGOImageView *sexImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *grayLabel;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self initView];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = BGViewColor;
    return self;
}

#pragma mark - View
- (void)initView{
    
    [self.contentView addSubview:self.faceImg];
    [self.contentView addSubview:self.sexImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.grayLabel];
    
    
    UIView *superView = self.contentView;
    
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(13);
        make.top.mas_equalTo(superView.mas_top).offset(23);
        make.width.height.mas_equalTo(@40);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_faceImg.mas_right);
        make.centerY.mas_equalTo(_faceImg.mas_top);
        make.width.height.mas_equalTo(@10);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_faceImg.mas_right).offset(20);
        make.top.mas_equalTo(_faceImg.mas_top);
        make.right.mas_equalTo(superView.mas_right).offset(-30);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.top.mas_equalTo(_faceImg.mas_top);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(@20);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_faceImg.mas_right).offset(20);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(superView.mas_right).offset(-30);
    }];
    
    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.right.mas_equalTo(superView.mas_right);
        make.top.mas_equalTo(_commentLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@0.5);
        make.bottom.mas_equalTo(superView.mas_bottom);
    }];
}

#pragma mark - Getters
- (EGOImageView *)faceImg{
    if (_faceImg == nil) {
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
    }
    return _faceImg;
}

- (EGOImageView *)sexImg{
    if (_sexImg == nil) {
        
        _sexImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"btn_share@2x"]];
    }
    return _sexImg;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        
        _nameLabel = [UILabel new];
        _nameLabel.text = @"MR_mistake";
        _nameLabel.textColor = BGViewGreen;
        _nameLabel.font = FONT_SIZE_13;
    }
    return _nameLabel;
}

- (UILabel *)commentLabel{
    if (_commentLabel == nil) {
        
        _commentLabel = [UILabel new];
        _commentLabel.numberOfLines = 0;
        NSString *commentString = @"回复327_破钟:虚伪的人，说出这种漂亮的话,回复327_破钟:虚伪的人，说出这种漂亮的话,回复327_破钟:虚伪的人，说出这种漂亮的话,回复327_破钟:虚伪的人，说出这种漂亮的话,回复327_破钟:虚伪的人，说出这种漂亮的话,回复327_破钟:虚伪的人，说出这种漂亮的话";
        NSInteger length = commentString.length;
        
        NSMutableAttributedString *attriButedString = [[NSMutableAttributedString alloc]initWithString:commentString];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:5];
        [attriButedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, length)];
        [attriButedString  addAttribute:NSFontAttributeName value:FONT_SIZE_13 range:NSMakeRange(0, length)];
        [attriButedString addAttribute:NSForegroundColorAttributeName value:COLOR_GRAY_DEFAULT_47 range:NSMakeRange(0, length)];
        [attriButedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:[commentString rangeOfString:@"327_破钟"]];
        _commentLabel.attributedText = attriButedString;
    }
    return _commentLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        
        _timeLabel = [UILabel new];
        _timeLabel.text = @"15分钟前";
        _timeLabel.font = FONT_SIZE_11;
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)grayLabel{
    if (_grayLabel == nil) {
        
        _grayLabel = [UILabel new];
        _grayLabel.backgroundColor = COLOR_GRAY_DEFAULT_133;
    }
    return _grayLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
