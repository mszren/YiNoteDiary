//
//  RecordView.m
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "RecordView.h"
#import "Masonry.h"
#import "MyTeamController.h"

@implementation RecordView {
    DBCameraViewController *_cameraController;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    self.backgroundColor = BGViewColor;
    return self;
}

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    NSData * data = UIImageJPEGRepresentation(image, 0.08f);
    UIImage * temp = [[UIImage alloc] initWithData:data];
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            
            MyTeamController *teamVc = [MyTeamController new];
            teamVc.hidesBottomBarWhenPushed = YES;
            [self.viewController.navigationController pushViewController:teamVc animated:YES];
        }
            
            break;
        case 101:{
            
//            _cameraController =
//            [DBCameraViewController initWithDelegate:self];
//            [_cameraController setUseCameraSegue:NO];
//            UINavigationController *nav = [[UINavigationController alloc]
//                                           initWithRootViewController:_cameraController];
//            [nav setNavigationBarHidden:YES];
//            [self.viewController presentViewController:nav animated:YES completion:nil];
            
 
            _cameraController = [DBCameraViewController initWithDelegate:self];
            [_cameraController setForceQuadCrop:YES];
            
            DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
            [container setCameraViewController:_cameraController];
            [container setFullScreenMode];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
            [nav setNavigationBarHidden:YES];
            [self.viewController presentViewController:nav animated:YES completion:nil];
 
        }
            
            break;
            
        default:
            break;
    }
}

- (void)initView{
    
    [self addSubview:self.grayLabel];
    [self addSubview:self.memberBtn];
    [self addSubview:self.cameraBtn];
    [self addSubview:self.finishBtn];
    
    [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.mas_equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
    
    [_memberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(13);
        make.height.width.mas_equalTo(@30);
    }];
    
    [_cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(@30);
    }];
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(13);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
}

- (UILabel *)grayLabel{
    if (!_grayLabel) {
        _grayLabel = [UILabel new];
        _grayLabel.backgroundColor = BGViewGray;
    }
    return _grayLabel;
}

- (UIButton *)memberBtn{
    if (!_memberBtn) {
        _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_memberBtn setImage:[UIImage imageNamed:@"ic_peoplenearby"] forState:UIControlStateNormal];
        _memberBtn.tag = 100;
        [_memberBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        _memberBtn.adjustsImageWhenHighlighted = NO;
    }
    return _memberBtn;
}

- (UIButton *)cameraBtn{
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"ic_nearphotos"] forState:UIControlStateNormal];
        _cameraBtn.tag = 101;
        [_cameraBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.adjustsImageWhenHighlighted = NO;
    }
    return _cameraBtn;
}

- (UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.tag = 102;
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = BOLDFont_SIZE_16;
        [_finishBtn setTitleColor:BGViewGreen forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

@end
