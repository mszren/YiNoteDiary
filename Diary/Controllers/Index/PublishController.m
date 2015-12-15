//
//  PublishController.m
//  Diary
//
//  Created by 我 on 15/11/13.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PublishController.h"
#import "Masonry.h"
#import "PublishAlbumTopView.h"
#import "EGOImageView.h"
#import "UzysAssetsPickerController.h"
#import "BaseNavigation.h"
#import "BaseNavigation.h"
#import "SelectAdressController.h"

@interface PublishController () <PublishAlbumTopViewDelegate,UITextViewDelegate,UzysAssetsPickerControllerDelegate>
@property (nonatomic,strong)UITextView *contentText;
@property (nonatomic,strong)UILabel *coverLabel;
@property (nonatomic,strong)PublishAlbumTopView *publishAlbumTopView;
@property (nonatomic,strong)UIView *addressView;
@property (nonatomic,strong)EGOImageView *addressImg;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong) EGOImageView *tapImg;
@property (nonatomic,strong)UzysAssetsPickerController* picker;;

@end

@implementation PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentText];
    [self.view addSubview:self.publishAlbumTopView];
    [self.view addSubview:self.addressView];
    [self initView];
}

- (void)initView{
    self.view.backgroundColor = BGViewGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(onPublishBtn:)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

#pragma mark -- UIBarButtonItem
- (void)onPublishBtn:(UIBarButtonItem *)sender{
    
}

#pragma mark PublishAlbumTopViewDelegate
- (void)showPickImgs:(NSMutableArray*)dataList
{
    
#if 0
    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
    appearanceConfig.finishSelectionButtonColor = BGViewGreen;
    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
    appearanceConfig.cellSpacing = 1.0f;
    appearanceConfig.assetsCountInALine = 4;
    [UzysAssetsPickerController defaultAssetsLibrary];
    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
#endif

    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 4;
    _picker.delegate = self;
    _picker.selectedAssetArray = _publishAlbumTopView.dataList;
    
    [self presentViewController:_picker
                       animated:YES
                     completion:^{
                         
                     }];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [_publishAlbumTopView addImgUrls:assets];
        
        
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
 
}

#pragma mark-- UITextFieldDelegate
- (void)textViewDidChange:(UITextView*)textView
{
    _contentText.text = textView.text;
    if (_contentText.text.length == 0) {
        _coverLabel.text = @"把你想说的话写下来...";
    }
    else {
        _coverLabel.text = @"";
    }
}

#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_contentText resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    SelectAdressController *addressVc = [SelectAdressController new];
    addressVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:nil];
    [super viewWillAppear:animated];
    UIView *superView = self.view;
    
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top);
        make.width.mas_equalTo(@(Screen_Width));
        make.height.mas_equalTo(@(150));
    }];
    
    [_coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentText.mas_left).offset(10);
        make.top.mas_equalTo(_contentText.mas_top).offset(10);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@15);
    }];
    
    [_publishAlbumTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_contentText.mas_bottom);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(@(48 + PublishImageTileHeight));
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(_publishAlbumTopView.mas_bottom).offset(10);
        make.width.mas_equalTo(@(Screen_Width));
        make.height.mas_equalTo(@40);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_addressView.mas_left).offset(10);
        make.top.mas_equalTo(_addressView.mas_top).offset(10);
        make.width.height.mas_equalTo(@20);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_addressImg.mas_right).offset(10);
        make.top.mas_equalTo(_addressView.mas_top);
        make.width.mas_equalTo(@(150));
        make.height.mas_equalTo(@40);
    }];
    
    [_tapImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_addressView.mas_right).offset(-10);
        make.top.mas_equalTo(_addressView.mas_top).offset(14);
        make.width.height.mas_equalTo(@12);
    }];
}

- (UITextView *)contentText{
    if (_contentText == nil) {
        _contentText = [UITextView new];
        _contentText.delegate = self;
        [_contentText addSubview:self.coverLabel];
        _contentText.font = FONT_SIZE_13;
    }
    return _contentText;
}

- (UILabel *)coverLabel{
    if (_coverLabel == nil) {
        _coverLabel = [UILabel new];
        _coverLabel.text = @"把你想说的话写下来...";
        _coverLabel.font = FONT_SIZE_13;
    }
    return _coverLabel;
}

- (PublishAlbumTopView *)publishAlbumTopView{
    if (_publishAlbumTopView == nil) {
        _publishAlbumTopView = [[PublishAlbumTopView alloc] init];
        [_publishAlbumTopView setViewDefault];
        _publishAlbumTopView.delegate = self;
        _publishAlbumTopView.imageMaxCount = 4;
    }
    return _publishAlbumTopView;
}

- (UIView *)addressView{
    if (_addressView == nil) {
        _addressView = [UIView new];
        _addressView.userInteractionEnabled = YES;
        UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        [_addressView addGestureRecognizer:addressTap];
        _addressView.backgroundColor = BGViewColor;
        [_addressView addSubview:self.addressImg];
        [_addressView addSubview:self.addressLabel];
        [_addressView addSubview:self.tapImg];
        _addressView.backgroundColor = BGViewColor;
    }
    return _addressView;
}

- (EGOImageView *)addressImg{
    if (_addressImg == nil) {
        _addressImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_landmark@3x"]];
    }
    return _addressImg;
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel new];
        _addressLabel.font = FONT_SIZE_15;
        _addressLabel.text = @"北京市朝阳区朝阳公园";
    }
    return _addressLabel;
}

- (EGOImageView *)tapImg{
    if (_tapImg == nil) {
        _tapImg = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:@"ic_arrow@3x"]];
    }
    return _tapImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
