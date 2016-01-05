//
//  MyAlbumHeadCell.m
//  Diary
//
//  Created by 我 on 16/1/5.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyAlbumHeadCell.h"
#import "EGOImageView.h"
#import "Masonry.h"

@interface MyAlbumHeadCell ()
@property (nonatomic, strong)EGOImageView *albumImg;

@end

@implementation MyAlbumHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _albumImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg"]];
        [self addSubview:_albumImg];
        [_albumImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.right.mas_equalTo(self.mas_right).offset(-13);
            make.height.mas_equalTo(@200);
        }];
        _albumImg.layer.cornerRadius = 6;
        _albumImg.clipsToBounds = YES;
        _albumImg.layer.shouldRasterize = YES;
        
    }
    self.backgroundColor = COLOR_GRAY_DEFAULT_240;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
