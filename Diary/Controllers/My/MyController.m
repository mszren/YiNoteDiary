//
//  MyController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "MyController.h"
#import "Masonry.h"
#import "EGOImageView.h"
#import "FriendMaterialController.h"
#import "SetController.h"
#import "PersonCenterController.h"

@interface MyController ()
@property (nonatomic,strong)EGOImageView *backGroundView;
@property (nonatomic,strong)UIButton *setBtn;
@property (nonatomic,strong)EGOImageView *faceImg;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIView *trailView;
@property (nonatomic,strong)EGOImageView *trailImg;
@property (nonatomic,strong)UILabel *trailLabel;
@property (nonatomic,strong)UILabel *trailCountryLabel;
@property (nonatomic,strong)UILabel *trailCityLabel;

@property (nonatomic,strong)UIView *albumView;
@property (nonatomic,strong)EGOImageView *albumImg;
@property (nonatomic,strong)UILabel *albumLabel;
@property (nonatomic,strong)UILabel *albumCountryLabel;
@property (nonatomic,strong)UILabel *albumCityLabel;

@property (nonatomic,strong)UILabel *verticalLabel;

@property (nonatomic,strong)UIView *likeView;
@property (nonatomic,strong)EGOImageView *likeImg;
@property (nonatomic,strong)UILabel *likeLabel;
@property (nonatomic,strong)EGOImageView *likeTapImg;

@property (nonatomic,strong)UIView *scanView;
@property (nonatomic,strong)EGOImageView *scanImg;
@property (nonatomic,strong)UILabel *scanLabel;
@property (nonatomic,strong)EGOImageView *scanTapImg;

@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
}

#pragma mark -- UIButton Action
- (void)onSetBtn:(UIButton *)sender{
    SetController *setVc = [SetController new];
    setVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVc animated:YES];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:{
            
            FriendMaterialController *friendVc = [FriendMaterialController new];
            friendVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:friendVc animated:YES];
        }
            
            break;
            
        default:{
            
            PersonCenterController *personVc = [PersonCenterController new];
            personVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personVc animated:YES];
        }
            break;
    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    UIView *superView = self.view;
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(superView.mas_top).offset(-20);
        make.left.width.mas_equalTo(superView);
        make.height.mas_equalTo(@(Screen_height));
    }];
    
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left);
        make.top.mas_equalTo(_scrollView.mas_top);
        make.width.mas_equalTo(_scrollView.mas_width);
        make.height.mas_equalTo(@287);
    }];
    
    [_setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backGroundView.mas_right).offset(-20);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(40);
        make.width.height.mas_equalTo(@30);
    }];
    
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.top.mas_equalTo(_backGroundView.mas_top).offset(80);
        make.width.height.mas_equalTo(@80);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backGroundView.mas_centerX);
        make.top.mas_equalTo(_faceImg.mas_bottom).offset(10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backGroundView.mas_centerX);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(23);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@50);
    }];
    
    [_trailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backGroundView.mas_left);
        make.top.mas_equalTo(_backGroundView.mas_bottom).offset(12);
        make.width.mas_equalTo(_backGroundView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(@103);
    }];
    
    [_trailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_trailView.mas_centerX).offset(-6);
        make.top.mas_equalTo(_trailView.mas_top).offset(20);
        make.height.and.width.mas_equalTo(@30);
    }];
    
    [_trailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_trailView.mas_centerX).offset(6);
        make.top.mas_equalTo(_trailImg.mas_top);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(_trailImg.mas_height);
    }];
    
    [_trailCountryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_trailView.mas_centerX);
        make.top.mas_equalTo(_trailImg.mas_bottom).offset(12);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@15);
    }];
    
    [_trailCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_trailCountryLabel.mas_right).offset(12);
        make.height.top.width.mas_equalTo(_trailCountryLabel);
    }];
    
    [_verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_trailView.mas_right);
        make.top.mas_equalTo(_trailView.mas_top).offset(20);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(63);
    }];
    
    [_albumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_trailView.mas_right);
        make.width.height.top.mas_equalTo(_trailView);
    }];
    
    [_albumImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_albumView.mas_centerX).offset(-6);
        make.top.mas_equalTo(_albumView.mas_top).offset(20);
        make.height.and.width.mas_equalTo(@30);
    }];
    
    [_albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_albumView.mas_centerX).offset(6);
        make.top.mas_equalTo(_albumImg.mas_top);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(_albumImg.mas_height);
    }];
    
    [_albumCountryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_albumView.mas_centerX);
        make.top.mas_equalTo(_albumImg.mas_bottom).offset(12);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@15);
    }];
    
    [_albumCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_albumCountryLabel.mas_right).offset(12);
        make.height.top.width.mas_equalTo(_albumCountryLabel);
    }];
    
    [_likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_trailView.mas_bottom).offset(12);
        make.leading.mas_equalTo(superView);
        make.width.mas_equalTo(superView.mas_width);
        make.height.mas_equalTo(@60);
    }];
    
    [_likeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_likeView.mas_left).offset(15);
        make.top.mas_equalTo(_likeView.mas_top).offset(15);
        make.width.height.mas_equalTo(@30);
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_likeImg.mas_right).offset(15);
        make.top.height.mas_equalTo(_likeView);
        make.width.mas_equalTo(@200);
    }];
    
    [_likeTapImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_likeView.mas_right).offset(-15);
        make.top.mas_equalTo(_likeView.mas_top).offset(22);
        make.width.height.mas_equalTo(@12);
    }];
    
    [_scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_likeView.mas_bottom).offset(0.5);
        make.left.width.height.mas_equalTo(_likeView);
    }];
    
    [_scanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scanView.mas_left).offset(15);
        make.top.mas_equalTo(_scanView.mas_top).offset(15);
        make.width.height.mas_equalTo(@30);
    }];
    
    [_scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scanImg.mas_right).offset(15);
        make.top.height.mas_equalTo(_scanView);
        make.width.mas_equalTo(@200);
    }];
    
    [_scanTapImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_scanView.mas_right).offset(-15);
        make.top.mas_equalTo(_scanView.mas_top).offset(22);
        make.width.height.mas_equalTo(@12);
    }];
    

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(Screen_Width, _scanView.frame.size.height + _scanView.frame.origin.y + 10);
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = BGViewGray;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView addSubview:self.backGroundView];
        [_scrollView addSubview:self.trailView];
        [_scrollView addSubview:self.albumView];
        [_scrollView addSubview:self.likeView];
        [_scrollView addSubview:self.scanView];
 
    }
    return _scrollView;
}

- (EGOImageView *)backGroundView{
    if (_backGroundView == nil) {
        _backGroundView = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bg"]];
        _backGroundView.userInteractionEnabled = YES;
        _backGroundView.tag = 100;
        UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        [_backGroundView addGestureRecognizer:backgroundTap];
        [_backGroundView addSubview:self.faceImg];
        [_backGroundView addSubview:self.nameLabel];
        [_backGroundView addSubview:self.titleLabel];
        [_backGroundView addSubview:self.setBtn];
    }
    return _backGroundView;
}

- (UIButton *)setBtn{
    if (_setBtn == nil) {
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setBtn setImage:[UIImage imageNamed:@"ic_aSet up@3x"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(onSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

- (EGOImageView *)faceImg{
    if (_faceImg == nil) {
        _faceImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_contacts@3x"]];
        _faceImg.layer.cornerRadius = 40;
        _faceImg.clipsToBounds = YES;
        _faceImg.layer.shouldRasterize = YES;
        _faceImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        _faceImg.tag = 101;
        [_faceImg addGestureRecognizer:faceTap];
    }
    return _faceImg;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"木子李";
        _nameLabel.textColor = BGViewColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = FONT_SIZE_18;
    }
    return _nameLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_SIZE_17;
        _titleLabel.textColor = BGViewColor;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"发现没日新鲜事，记录美好生活的瞬间，一起去旅行吧！";
    }
    return _titleLabel;
}

- (UIView *)trailView{
    if (_trailView == nil) {
        _trailView = [UIView new];
        _trailView.backgroundColor = BGViewColor;
        [_trailView addSubview:self.trailImg];
        [_trailView addSubview:self.trailLabel];
        [_trailView addSubview:self.trailCountryLabel];
        [_trailView addSubview:self.trailCityLabel];
        [_trailView addSubview:self.verticalLabel];
    }
    return _trailView;
}

- (EGOImageView *)trailImg{
    if (_trailImg == nil) {
        _trailImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_locus@3x"]];
    }
    return _trailImg;
}

- (UILabel *)trailLabel{
    if (_trailLabel == nil) {
        _trailLabel = [UILabel new];
        _trailLabel.text = @"轨迹";
        _trailLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _trailLabel.font = FONT_SIZE_19;
    }
    return _trailLabel;
}

- (UILabel *)trailCountryLabel{
    if (_trailCountryLabel == nil) {
        _trailCountryLabel = [UILabel new];
        _trailCountryLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _trailCountryLabel.text = @"0国家";
        _trailCountryLabel.font = FONT_SIZE_17;
        _trailCountryLabel.textAlignment = NSTextAlignmentRight;
    }
    return _trailCountryLabel;
}

- (UILabel *)trailCityLabel{
    if (_trailCityLabel == nil) {
        _trailCityLabel = [UILabel new];
        _trailCityLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _trailCityLabel.text = @"0城市";
        _trailCityLabel.font = FONT_SIZE_17;
    }
    return _trailCityLabel;
}

- (UILabel *)verticalLabel{
    if (_verticalLabel == nil) {
        _verticalLabel = [UILabel new];
        _verticalLabel.backgroundColor = COLOR_GRAY_DEFAULT_190;
    }
    return _verticalLabel;
}

- (UIView *)albumView{
    if (_albumView == nil) {
        _albumView = [UIView new];
        _albumView.backgroundColor = BGViewColor;
        [_albumView addSubview:self.albumImg];
        [_albumView addSubview:self.albumLabel];
        [_albumView addSubview:self.albumCountryLabel];
        [_albumView addSubview:self.albumCityLabel];
    }
    return _albumView;
}

- (EGOImageView *)albumImg{
    if (_albumImg == nil) {
        _albumImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_albums@3x"]];
    }
    return _albumImg;
}

- (UILabel *)albumLabel{
    if (_albumLabel == nil) {
        _albumLabel = [UILabel new];
        _albumLabel.text = @"专辑";
        _albumLabel.textColor = COLOR_GRAY_DEFAULT_47;
        _albumLabel.font = FONT_SIZE_19;
    }
    return _albumLabel;
}

- (UILabel *)albumCountryLabel{
    if (_albumCountryLabel == nil) {
        _albumCountryLabel = [UILabel new];
        _albumCountryLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _albumCountryLabel.text = @"0国家";
        _albumCountryLabel.font = FONT_SIZE_17;
        _albumCountryLabel.textAlignment = NSTextAlignmentRight;
    }
    return _albumCountryLabel;
}

- (UILabel *)albumCityLabel{
    if (_albumCityLabel == nil) {
        _albumCityLabel = [UILabel new];
        _albumCityLabel.textColor = COLOR_GRAY_DEFAULT_180;
        _albumCityLabel.text = @"0城市";
        _albumCityLabel.font = FONT_SIZE_17;
    }
    return _albumCityLabel;
}

- (UIView *)likeView{
    if (_likeView == nil) {
        _likeView = [UIView new];
        _likeView.backgroundColor = BGViewColor;
        [_likeView addSubview:self.likeImg];
        [_likeView addSubview:self.likeLabel];
        [_likeView addSubview:self.likeTapImg];
    }
    return _likeView;
}

- (EGOImageView *)likeImg{
    
    if (_likeImg == nil) {
        _likeImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_collect@3x"]];
    }
    return _likeImg;
}

- (UILabel *)likeLabel{
    if (_likeLabel == nil) {
        _likeLabel = [UILabel new];
        _likeLabel.text = @"XXXXXX";
        _likeLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _likeLabel.font = FONT_SIZE_15;
    }
    return _likeLabel;
}

- (EGOImageView *)likeTapImg{
    if (_likeTapImg == nil) {
        _likeTapImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_arrow@3x"]];
    }
    return _likeTapImg;
}

- (UIView *)scanView{
    if (_scanView == nil) {
        _scanView = [UIView new];
        _scanView.backgroundColor = BGViewColor;
        [_scanView addSubview:self.scanImg];
        [_scanView addSubview:self.scanLabel];
        [_scanView addSubview:self.scanTapImg];
    }
    return _scanView;
}

- (EGOImageView *)scanImg{
    
    if (_scanImg == nil) {
        _scanImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_sweep the@3x"]];
    }
    return _scanImg;
}

- (UILabel *)scanLabel{
    if (_scanLabel == nil) {
        _scanLabel = [UILabel new];
        _scanLabel.text = @"XXXXXX";
        _scanLabel.textColor = COLOR_GRAY_DEFAULT_133;
        _likeLabel.font = FONT_SIZE_15;
    }
    return _scanLabel;
}

- (EGOImageView *)scanTapImg{
    if (_scanTapImg == nil) {
        _scanTapImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"ic_arrow@3x"]];
    }
    return _scanTapImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
