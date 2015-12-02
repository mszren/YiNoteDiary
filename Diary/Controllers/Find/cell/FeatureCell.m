//
//  FeatureCell.m
//  Diary
//
//  Created by 我 on 15/11/16.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FeatureCell.h"
#import "EGOImageView.h"
#import "Masonry.h"

@implementation FeatureCell{
    EGOImageView *_featureImg;
    UILabel *_featureLabel;
    UILabel *_styleLabel;
    UILabel *_priceLabel;
    UILabel *_addressLabel;
    UILabel *_grayLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _featureImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_featureImg];
        [_featureImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(13);
            make.width.height.mas_equalTo(@60);
        }];
        _featureImg.layer.cornerRadius = 4;
        _featureImg.clipsToBounds = YES;
        _featureImg.layer.shouldRasterize = YES;
        
        _featureLabel = [UILabel new];
        [self addSubview:_featureLabel];
        [_featureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_featureImg.mas_right).offset(13);
            make.top.mas_equalTo(_featureImg.mas_top);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@20);
        }];
        _featureLabel.text = @"北京龙潭公园";
        _featureLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _featureLabel.font = FONT_SIZE_15;
        
        _styleLabel = [UILabel new];
        [self addSubview:_styleLabel];
        [_styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_featureImg.mas_right).offset(13);
            make.top.mas_equalTo(_featureLabel.mas_bottom).offset(20);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        NSString *string = @"AAAA 景区";
        NSInteger length = string.length;
        NSRange range = [string rangeOfString:@"景区"];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
        [attributeString addAttribute:NSFontAttributeName value:FONT_SIZE_13 range:NSMakeRange(0, length)];
          [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[string rangeOfString:@"景区"]];
        [attributeString addAttribute:NSForegroundColorAttributeName value:COLOR_GRAY_DEFAULT_133 range:NSMakeRange(0, range.location)];
        _styleLabel.attributedText = attributeString;
        
        _priceLabel = [UILabel new];
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_styleLabel.mas_right).offset(10);
            make.top.mas_equalTo(_styleLabel.mas_top);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        _priceLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _priceLabel.font = FONT_SIZE_13;
        _priceLabel.text = @"门票 :20";
        
        _addressLabel = [UILabel new];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(15);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@15);
        }];
        _addressLabel.text = @"0.0米";
        _addressLabel.font = FONT_SIZE_11;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_133;
        
        _grayLabel = [UILabel new];
        [self addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(_featureImg.mas_bottom).offset(13);
            make.width.mas_equalTo(@(Screen_Width));
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
