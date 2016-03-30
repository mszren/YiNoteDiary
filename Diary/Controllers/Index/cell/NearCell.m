//
//  NearCell.m
//  Diary
//
//  Created by 我 on 15/11/12.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "NearCell.h"
#import "Masonry.h"
#import "EGOImageView.h"

#define KImagePadding     4
#define KContentCellWidth (Screen_Width - 20)
#define KImageWidth       (Screen_Width - 20 - 2*KImagePadding)/3
#define KImageHeight      (Screen_Width - 20 - 2*KImagePadding)/3
@implementation NearCell{
    EGOImageView *_faceImg;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UIButton *_addBtn;
    UILabel *_titleLabel;
    EGOImageView *_contentImg;
    UIButton *_addressBtn;
    UILabel *_addressLabel;
    UIButton *_praiseBtn;
    UILabel *_preiseLabel;
    UIButton *_commentBtn;
    UILabel *_commentLabel;
    UIButton *_attentionBtn;
    UILabel *_attentionLabel;
    UIView *_backGroundView;
    CGFloat _height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backGroundView = [UIView new];
        [self addSubview:_backGroundView];
        [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(@(Screen_Width));
            make.height.mas_equalTo(@131);
        }];
        _backGroundView.backgroundColor = BGViewColor;
        
        _faceImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [_backGroundView addSubview:_faceImg];
        [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
            make.top.mas_equalTo(_backGroundView.mas_top).offset(10);
            make.width.height.mas_equalTo(@40);
        }];
        _faceImg.layer.cornerRadius = 4;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        
        _nameLabel = [UILabel new];
        [_backGroundView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_faceImg.mas_top);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@20);
        }];
        _nameLabel.text = @"行走的袋鼠";
        _nameLabel.font = FONT_SIZE_16;
        _nameLabel.textColor = COLOR_GRAY_DEFAULT_47;
        
        _timeLabel = [UILabel new];
        [_backGroundView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_faceImg.mas_right).offset(10);
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@20);
        }];
        _timeLabel.text = @"53分钟前";
        _timeLabel.font = FONT_SIZE_13;
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_133;
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_backGroundView.mas_right).offset(-20);
            make.top.mas_equalTo(_backGroundView.mas_top).offset(20);
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(@30);
        }];
        [_addBtn setTitle:@"好友" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = FONT_SIZE_14;
        
        _titleLabel = [UILabel new];
        [_backGroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(_faceImg.mas_bottom).offset(10);
            make.width.mas_equalTo(@250);
            make.height.mas_equalTo(@20);
        }];
        _titleLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _titleLabel.text = @"美丽神秘的丽江之行";
        _titleLabel.font = FONT_SIZE_15;
        
        _contentImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@""]];
        [_backGroundView addSubview:_contentImg];
        [_contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
//            make.width.mas_equalTo(@(Screen_Width - 20));
//            make.height.mas_equalTo(@200);
        }];
        _contentImg.backgroundColor = BGViewColor;
        
        _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_addressBtn];
        [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backGroundView.mas_left).offset(10);
            make.top.mas_equalTo(_contentImg.mas_bottom).offset(11);
            make.width.height.mas_equalTo(@20);
        }];
        [_addressBtn setImage:[UIImage imageNamed:@"ic_landmark@3x"] forState:UIControlStateNormal];
        
        _addressLabel = [UILabel new];
        [_backGroundView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_addressBtn.mas_right).offset(5);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        _addressLabel.text = @"云南-丽江";
        _addressLabel.font = FONT_SIZE_15;
        _addressLabel.textColor = COLOR_GRAY_DEFAULT_180;
        
        _attentionLabel = [UILabel new];
        [_backGroundView addSubview:_attentionLabel];
        [_attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_backGroundView.mas_right).offset(-10);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _attentionLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _attentionLabel.text = @"1.6万";
        _attentionLabel.font = FONT_SIZE_11;
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_attentionLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_attentionLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_attentionBtn setImage:[UIImage imageNamed:@"ic_browse@3x"] forState:UIControlStateNormal];
        
        _commentLabel = [UILabel new];
        [_backGroundView addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_attentionBtn.mas_right).offset(-20);
            make.top.mas_equalTo(_addressBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _commentLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _commentLabel.text = @"8";
        _commentLabel.font = FONT_SIZE_11;
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_commentLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_commentBtn setImage:[UIImage imageNamed:@"ic_review@3x"] forState:UIControlStateNormal];
        
        _preiseLabel = [UILabel new];
        [_backGroundView addSubview:_preiseLabel];
        [_preiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_commentBtn.mas_right).offset(-20);
            make.top.mas_equalTo(_commentBtn.mas_top);
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@20);
        }];
        _preiseLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _preiseLabel.text = @"14";
        _preiseLabel.font = FONT_SIZE_11;
        
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backGroundView addSubview:_praiseBtn];
        [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_preiseLabel.mas_left).offset(-5);
            make.top.mas_equalTo(_preiseLabel.mas_top);
            make.width.height.mas_equalTo(@20);
        }];
        [_praiseBtn setImage:[UIImage imageNamed:@"ic_like@3x"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)bindData:(NSInteger)count{
    
    /**
     *  获取图片CGSize
     */
    CGSize size;
    switch (count) {
        case 1:
            size = CGSizeMake(KContentCellWidth/2, KContentCellWidth/2);
            break;
        default:
            
            size = CGSizeMake(KImageWidth, KImageHeight);
            break;
    }

    /**
     *  移除_contentImg上的子视图
     */
    NSArray *subview = _contentImg.subviews;
    for (UIView *v in subview) {
        [v removeFromSuperview];
    }
    
    /**
     *  _contentImg上添加图片视图
     */
        for (NSInteger i = 0; i < 9; i++) {
            
            if (i < count) {
                UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bg"]];
                image.contentMode = UIViewContentModeScaleAspectFill;
                image.clipsToBounds = YES;
                image.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                CGFloat x = i%3*(KImageWidth + KImagePadding);
                CGFloat y = i/3*(KImageHeight + KImagePadding);
                
                image.frame = CGRectMake(x, y, size.width, size.height);
               [_contentImg addSubview:image];
            
            }
            
            /**
             *  获取_contentImg高度
             */
            switch (count) {
                case 0:
                    _height = 0;
                    break;
                case 1:
                    _height = KContentCellWidth/2;
                    break;
                case 2:case 3:
                    _height = KImageHeight;
                    break;
                case 4:case 5:case 6:
                    _height = KImageHeight*2 + KImagePadding;
                    break;
                default:
                    _height = KImageHeight*3 + KImagePadding*2;
                    break;
            }
            
            if ([self.delegate respondsToSelector:@selector(cellHeight:)]) {
                
                [self.delegate cellHeight:_height];
            }
            

            /**
             *  更新UI界面Frame
             *
             *  @param make
             *
             *  @return
             */
            [_backGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo( _height + 131);
            }];
            
            [_contentImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(KContentCellWidth, _height));
            }];
            
            [_addressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_contentImg.mas_bottom).offset(11);
            }];

            [_addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_addressBtn.mas_top);
            }];
            
            [_attentionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_addressBtn.mas_top);
            }];
            
            [_attentionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_attentionLabel.mas_top);
            }];
            
            [_commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_addressBtn.mas_top);
            }];
            
            [_commentBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_commentLabel.mas_top);
            }];
            
            [_preiseLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_commentBtn.mas_top);
            }];
            
            [_praiseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_preiseLabel.mas_top);
            }];
        
        }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
