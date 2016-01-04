//
//  OtherTrailView.m
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "OtherTrailView.h"
#import "Masonry.h"

@implementation OtherTrailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    return self;
}

- (void)setName:(NSString *)nameStr andContent:(NSString *)contentStr andImage:(UIImage *)faceImg{
    [_nameLabel setText:nameStr];
    [_contentLabel setText:contentStr];
    [_faceImgView setImage:faceImg];
}

- (void)initView{
    
    [self addSubview:self.faceImgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    
    [_faceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.height.width.mas_equalTo(@80);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_faceImgView.mas_bottom).offset(13);
        make.width.mas_equalTo(@200);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(13);
        make.width.mas_equalTo(@280);
    }];
}

- (EGOImageView *)faceImgView{
    if (!_faceImgView) {
        _faceImgView = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bg"]];
        _faceImgView.layer.cornerRadius = 40;
        _faceImgView.clipsToBounds = YES;
        _faceImgView.layer.shouldRasterize = YES;
        _faceImgView.layer.borderWidth = 2;
        _faceImgView.layer.borderColor = BGViewColor.CGColor;
    }
    return _faceImgView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = BGViewColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = BOLDFont_SIZE_17;
        _nameLabel.text = self.nameStr;
        NSLog(@"name : %@",self.nameStr);
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = BGViewColor;
        _contentLabel.font = BOLDFont_SIZE_17;
        _contentLabel.text = @"当前拍摄了120张照片";
    }
    return _contentLabel;
}


@end
