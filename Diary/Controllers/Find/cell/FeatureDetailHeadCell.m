//
//  FeatureDetailHeadCell.m
//  Diary
//
//  Created by 我 on 15/11/16.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FeatureDetailHeadCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

@interface FeatureDetailHeadCell()
@property (nonatomic,strong) UILabel *featureLabel;
@property (nonatomic,strong) UILabel *commentCountLabel;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UILabel *greenLabel;
@property (nonatomic,strong) UILabel *leftRecommendLabel;
@property (nonatomic,strong) UILabel *rightRecommendLabel;
@property (nonatomic,strong) UIButton *recommendBtn;
@property (nonatomic,strong) UILabel *recommentContentLabel;
@property (nonatomic,strong) UILabel *recommendBottomLabel;

@property (nonatomic,strong) UILabel *introduceGreenLabel;
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) UILabel *introduceContentLabel;
@property (nonatomic,strong) UILabel *introduceGrayLabel;

@property (nonatomic,strong) UILabel *referGreenLabel;
@property (nonatomic,strong) UILabel *referLabel;
@property (nonatomic,strong) UILabel *referContentLabel;
@property (nonatomic,strong) UILabel *referGrayLabel;

@property (nonatomic,strong) UILabel *timeGreenLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *timeContentLabel;
@property (nonatomic,strong) UILabel *timeGrayLabel;

@property (nonatomic,strong) UILabel *priceGreenLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *priceContentLabel;
@property (nonatomic,strong) UILabel *priceGrayLabel;

@property (nonatomic,strong) UILabel *urlGreenLabel;
@property (nonatomic,strong) UILabel *urlLabel;
@property (nonatomic,strong) UILabel *urlContentLabel;

@property (nonatomic,strong) UILabel *orangeLabel;
@property (nonatomic,strong) UILabel *leftNewLabel;
@property (nonatomic,strong) UILabel *rightNewLabel;
@property (nonatomic,strong) UIButton *lasteCommentBtn;

@end

@implementation FeatureDetailHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self initView];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = BGViewColor;
    return self;
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    

}

#pragma mark -- UITapGestureRecognizer
- (void)onUrlTap:(UITapGestureRecognizer *)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlContentLabel.text]];
}

- (void)initView{
    
    [self.contentView addSubview:self.featureLabel];
    [self.contentView addSubview:self.commentCountLabel];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.greenLabel];
    [self.contentView addSubview:self.leftRecommendLabel];
    [self.contentView addSubview:self.rightRecommendLabel];
    [self.contentView addSubview:self.recommendBtn];
    [self.contentView addSubview:self.recommentContentLabel];
    [self.contentView addSubview:self.recommendBottomLabel];
    [self.contentView addSubview:self.introduceGreenLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.introduceContentLabel];
    [self.contentView addSubview:self.introduceGrayLabel];
    [self.contentView addSubview:self.referGreenLabel];
    [self.contentView addSubview:self.referLabel];
    [self.contentView addSubview:self.referContentLabel];
    [self.contentView addSubview:self.referGrayLabel];
    [self.contentView addSubview:self.timeGreenLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.timeContentLabel];
    [self.contentView addSubview:self.timeGrayLabel];
    [self.contentView addSubview:self.priceGreenLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.priceContentLabel];
    [self.contentView addSubview:self.priceGrayLabel];
    [self.contentView addSubview:self.urlGreenLabel];
    [self.contentView addSubview:self.urlLabel];
    [self.contentView addSubview:self.urlContentLabel];
    [self.contentView addSubview:self.orangeLabel];
    [self.contentView addSubview:self.leftNewLabel];
    [self.contentView addSubview:self.rightNewLabel];
    [self.contentView addSubview:self.lasteCommentBtn];
    
    UIView *superView = self.contentView;
    
    [_featureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(superView.mas_top).offset(13);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.height.mas_equalTo(@15);
    }];
    
    [_commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_featureLabel);
        make.top.mas_equalTo(_featureLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(@15);
    }];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.top.mas_equalTo(_featureLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_likeBtn.mas_left).offset(-20);
        make.top.width.height.mas_equalTo(_likeBtn);
    }];
    
    [_greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_commentCountLabel.mas_bottom).offset(40);
        make.width.mas_equalTo(@(Screen_Width));
        make.height.mas_equalTo(@(5));
    }];
    
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView);
        make.top.mas_equalTo(_greenLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_leftRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.right.mas_equalTo(_recommendBtn.mas_left).offset(-20);
        make.centerY.mas_equalTo(_recommendBtn);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_rightRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_recommendBtn.mas_right).offset(20);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.centerY.mas_equalTo(_recommendBtn);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_recommentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_recommendBtn.mas_bottom).offset(20);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_recommendBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_recommentContentLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_introduceGreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_recommendBottomLabel.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_introduceGreenLabel.mas_right).offset(5);
        make.top.height.mas_equalTo(_introduceGreenLabel);
        make.width.mas_equalTo(@60);
    }];
    
    [_introduceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_introduceLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_introduceGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(_introduceContentLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_referGreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_introduceGrayLabel.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
    [_referLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_referGreenLabel.mas_right).offset(5);
        make.top.height.mas_equalTo(_referGreenLabel);
        make.width.mas_equalTo(@60);
    }];
    
    [_referContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_referLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_referGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(_referContentLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_timeGreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_referGrayLabel.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeGreenLabel.mas_right).offset(5);
        make.top.height.mas_equalTo(_timeGreenLabel);
        make.width.mas_equalTo(@60);
    }];
    
    [_timeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_timeGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(_timeContentLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_priceGreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_timeGrayLabel.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceGreenLabel.mas_right).offset(5);
        make.top.height.mas_equalTo(_priceGreenLabel);
        make.width.mas_equalTo(@60);
    }];
    
    [_priceContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_priceGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(_priceContentLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_urlGreenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_priceGrayLabel.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
    [_urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_urlGreenLabel.mas_right).offset(5);
        make.top.height.mas_equalTo(_urlGreenLabel);
        make.width.mas_equalTo(@60);
    }];
    
    [_urlContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.top.mas_equalTo(_urlLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
    }];
    
    [_orangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(superView);
        make.top.mas_equalTo(_urlContentLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(@5);
    }];
    
    
    [_lasteCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView);
        make.top.mas_equalTo(_orangeLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-10);
    }];
    
    [_leftNewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(20);
        make.right.mas_equalTo(_lasteCommentBtn.mas_left).offset(-20);
        make.centerY.mas_equalTo(_lasteCommentBtn);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_rightNewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lasteCommentBtn.mas_right).offset(20);
        make.right.mas_equalTo(superView.mas_right).offset(-20);
        make.centerY.mas_equalTo(_lasteCommentBtn);
        make.height.mas_equalTo(@0.5);
    }];
    
}

#pragma mark - Getters

- (UILabel *)featureLabel{
    if (_featureLabel == nil) {
        _featureLabel = [UILabel new];
        _featureLabel.text = @"奥林匹克公园";
        _featureLabel.font = FONT_SIZE_17;
        _featureLabel.textColor = COLOR_GRAY_DEFAULT_47;
    }
    return _featureLabel;
}

- (UILabel *)commentCountLabel{
    if (_commentCountLabel == nil) {
        _commentCountLabel = [UILabel new];
        _commentCountLabel.textColor = COLOR_GRAY_DEFAULT_153;
        _commentCountLabel.text = @"12条点评";
        _commentCountLabel.font = FONT_SIZE_15;
    }
    return _commentCountLabel;
}

- (UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        _likeBtn.layer.borderWidth = 0.8;
        _likeBtn.layer.cornerRadius = 8;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.3, 0.6, 0.6, 1 });
        CGColorSpaceRelease(colorSpace);
        _likeBtn.layer.borderColor = borderColorRef;
        CGColorRelease(borderColorRef);
        _likeBtn.titleLabel.font = FONT_SIZE_17;
        [_likeBtn setTitleColor:COLOR_GRAY_DEFAULT_153 forState:UIControlStateNormal];
        _likeBtn.tag = 100;
        [_likeBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UILabel *)greenLabel{
    if (_greenLabel == nil) {
        _greenLabel = [UILabel new];
        _greenLabel.backgroundColor = BGViewGreen;
    }
    return _greenLabel;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"点评" forState:UIControlStateNormal];
        _commentBtn.layer.borderWidth = 0.8;
        _commentBtn.layer.cornerRadius = 8;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){ 0.3, 0.6, 0.6, 1 });
        CGColorSpaceRelease(colorSpace);
        _commentBtn.layer.borderColor = borderColorRef;
        CGColorRelease(borderColorRef);
        _commentBtn.titleLabel.font = FONT_SIZE_17;
        [_commentBtn setTitleColor:COLOR_GRAY_DEFAULT_153 forState:UIControlStateNormal];
        _commentBtn.tag = 101;
        [_commentBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIButton *)recommendBtn{
    if (_recommendBtn == nil) {
        _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recommendBtn setTitleColor:BGViewColor forState:UIControlStateNormal];
        [_recommendBtn setTitle:@"推荐理由" forState:UIControlStateNormal];
        _recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _recommendBtn.layer.cornerRadius = 15;
        _recommendBtn.clipsToBounds = YES;
        _recommendBtn.layer.shouldRasterize = YES;
        _recommendBtn.backgroundColor = BGViewGreen;
    }
    return _recommendBtn;
}

- (UILabel *)leftRecommendLabel{
    if (_leftRecommendLabel == nil) {
        _leftRecommendLabel = [UILabel new];
        _leftRecommendLabel.backgroundColor = BGViewGreen;
    }
    return _leftRecommendLabel;
}

- (UILabel *)rightRecommendLabel{
    if (_rightRecommendLabel == nil) {
        _rightRecommendLabel = [UILabel new];
        _rightRecommendLabel.backgroundColor = BGViewGreen;
    }
    return _rightRecommendLabel;
}

- (UILabel *)recommentContentLabel{
    if (_recommentContentLabel == nil) {
        _recommentContentLabel = [UILabel new];
        _recommentContentLabel.text = @"亚洲最大的城市绿化景观，北京最大的城市公园，29届奥运会的后花园";
        _recommentContentLabel.font = FONT_SIZE_13;
        _recommentContentLabel.numberOfLines = 0;
        _recommentContentLabel.textColor = COLOR_GRAY_DEFAULT_133;
    }
    return _recommentContentLabel;
}

- (UILabel *)recommendBottomLabel{
    if (_recommendBottomLabel == nil) {
        _recommendBottomLabel = [UILabel new];
        _recommendBottomLabel.backgroundColor = BGViewGreen;
    }
    return _recommendBottomLabel;
}

- (UILabel *)introduceGreenLabel{
    if (_introduceGreenLabel == nil) {
        _introduceGreenLabel = [UILabel new];
        _introduceGreenLabel.backgroundColor = BGViewGreen;
    }
    return _introduceGreenLabel;
}

- (UILabel *)introduceLabel{
    if (_introduceLabel == nil) {
        _introduceLabel = [UILabel new];
        _introduceLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _introduceLabel.text = @"简介";
        _introduceLabel.font = FONT_SIZE_15;
    }
    return _introduceLabel;
}

- (UILabel *)introduceContentLabel{
    if (_introduceContentLabel == nil) {
        _introduceContentLabel = [UILabel new];
        _introduceContentLabel.font = FONT_SIZE_13;
        _introduceContentLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _introduceContentLabel.text = @"奥林匹克森林公园位于北京市朝阳区北五环林萃路，东至安立路，西至林萃路，北至清河，南至科荟路。公园占地680公顷，其中南园占地380公顷，北园占地300公顷。公园森林资源丰富，以乔灌木为主，绿化覆盖率95.61%。奥林匹克森林公园是奥林匹克公园的终点配套建设项目之一，而奥林匹克公园是国家AAAAA级旅游景区。";
        _introduceContentLabel.numberOfLines = 0;
    }
    return _introduceContentLabel;
}

- (UILabel *)introduceGrayLabel{
    if (_introduceGrayLabel == nil) {
        _introduceGrayLabel = [UILabel new];
        _introduceGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT_190;
    }
    return _introduceGrayLabel;
}

- (UILabel *)referGreenLabel{
    if (_referGreenLabel == nil) {
        _referGreenLabel = [UILabel new];
        _referGreenLabel.backgroundColor = BGViewGreen;
    }
    return _referGreenLabel;
}

- (UILabel *)referLabel{
    if (_referLabel == nil) {
        _referLabel = [UILabel new];
        _referLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _referLabel.text = @"用时参考";
        _referLabel.font = FONT_SIZE_15;
    }
    return _referLabel;
}

- (UILabel *)referContentLabel{
    if (_referContentLabel == nil) {
        _referContentLabel = [UILabel new];
        _referContentLabel.font = FONT_SIZE_13;
        _referContentLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _referContentLabel.text = @"1天";
        _referContentLabel.numberOfLines = 0;
    }
    return _referContentLabel;
}

- (UILabel *)referGrayLabel{
    if (_referGrayLabel == nil) {
        _referGrayLabel = [UILabel new];
        _referGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT_190;
    }
    return _referGrayLabel;
}

- (UILabel *)timeGreenLabel{
    if (_timeGreenLabel == nil) {
        _timeGreenLabel = [UILabel new];
        _timeGreenLabel.backgroundColor = BGViewGreen;
    }
    return _timeGreenLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _timeLabel.text = @"开放时间";
        _timeLabel.font = FONT_SIZE_15;
    }
    return _timeLabel;
}

- (UILabel *)timeContentLabel{
    if (_timeContentLabel == nil) {
        _timeContentLabel = [UILabel new];
        _timeContentLabel.font = FONT_SIZE_13;
        _timeContentLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _timeContentLabel.text = @"包括雪景、雨景、云海、朝晖、夕阳、佛光、蜃景、极光、雾凇、彩霞及其他天象景观。";
        _timeContentLabel.numberOfLines = 0;
    }
    return _timeContentLabel;
}

- (UILabel *)timeGrayLabel{
    if (_timeGrayLabel == nil) {
        _timeGrayLabel = [UILabel new];
        _timeGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT_190;
    }
    return _timeGrayLabel;
}

- (UILabel *)priceGreenLabel{
    if (_priceGreenLabel == nil) {
        _priceGreenLabel = [UILabel new];
        _priceGreenLabel.backgroundColor = BGViewGreen;
    }
    return _priceGreenLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _priceLabel.text = @"门票";
        _priceLabel.font = FONT_SIZE_15;
    }
    return _priceLabel;
}

- (UILabel *)priceContentLabel{
    if (_priceContentLabel == nil) {
        _priceContentLabel = [UILabel new];
        _priceContentLabel.font = FONT_SIZE_13;
        _priceContentLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _priceContentLabel.text = @"免费";
        _priceContentLabel.numberOfLines = 0;
    }
    return _priceContentLabel;
}

- (UILabel *)priceGrayLabel{
    if (_priceGrayLabel == nil) {
        _priceGrayLabel = [UILabel new];
        _priceGrayLabel.backgroundColor = COLOR_GRAY_DEFAULT_190;
    }
    return _priceGrayLabel;
}

- (UILabel *)urlGreenLabel{
    if (_urlGreenLabel == nil) {
        _urlGreenLabel = [UILabel new];
        _urlGreenLabel.backgroundColor = BGViewGreen;
    }
    return _urlGreenLabel;
}

- (UILabel *)urlLabel{
    if (_urlLabel == nil) {
        _urlLabel = [UILabel new];
        _urlLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _urlLabel.text = @"网址";
        _urlLabel.font = FONT_SIZE_15;
    }
    return _urlLabel;
}

- (UILabel *)urlContentLabel{
    if (_urlContentLabel == nil) {
        _urlContentLabel = [UILabel new];
        _urlContentLabel.font = FONT_SIZE_13;
        _urlContentLabel.textColor = BGViewLightGreen;
        _urlContentLabel.text = @"http://www.baidu.com";
        _urlContentLabel.numberOfLines = 0;
        _urlContentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *urlTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onUrlTap:)];
        [_urlContentLabel addGestureRecognizer:urlTap];
    }
    return _urlContentLabel;
}

- (UILabel *)orangeLabel{
    if (_orangeLabel == nil) {
        _orangeLabel = [UILabel new];
        _orangeLabel.backgroundColor = COLOR_Orange_230;
    }
    return _orangeLabel;
}

- (UIButton *)lasteCommentBtn{
    if (_lasteCommentBtn == nil) {
        _lasteCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lasteCommentBtn setTitleColor:BGViewColor forState:UIControlStateNormal];
        [_lasteCommentBtn setTitle:@"最新点评" forState:UIControlStateNormal];
        _lasteCommentBtn.titleLabel.font = FONT_SIZE_17;
        _lasteCommentBtn.layer.cornerRadius = 15;
        _lasteCommentBtn.clipsToBounds = YES;
        _lasteCommentBtn.layer.shouldRasterize = YES;
        _lasteCommentBtn.backgroundColor = COLOR_Orange_230;
    }
    return _lasteCommentBtn;
}

- (UILabel *)leftNewLabel{
    if (_leftNewLabel == nil) {
        _leftNewLabel = [UILabel new];
        _leftNewLabel.backgroundColor = COLOR_Orange_230;
    }
    return _leftNewLabel;
}

- (UILabel *)rightNewLabel{
    if (_rightNewLabel == nil) {
        _rightNewLabel = [UILabel new];
        _rightNewLabel.backgroundColor = COLOR_Orange_230;
    }
    return _rightNewLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
