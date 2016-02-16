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
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITextView *contentText;
@property (nonatomic,strong)UILabel *coverLabel;
@property (nonatomic,strong)PublishAlbumTopView *publishAlbumTopView;
@property (nonatomic,strong)UIView *addressView;
@property (nonatomic,strong)EGOImageView *addressImg;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong) EGOImageView *tapImg;
@property (nonatomic,strong)UzysAssetsPickerController* picker;

@end

@implementation PublishController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
   
    [self.view addSubview:self.scrollView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(onPublishBtn:)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

#pragma mark - PublishAlbumTopViewDelegate
- (void)showPickImgs:(NSMutableArray*)dataList
{
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = 0;
    _picker.maximumNumberOfSelectionPhoto = 8;
    _picker.delegate = self;
    NSLog(@"dalist : %@",dataList);
    _picker.selectedAssetArray = dataList;
    [self presentViewController:_picker
                       animated:YES
                     completion:^{
                         
                     }];
}

- (void)updateFrame{
    
    CGRect frame = _addressView.frame;
    frame.origin.y = _publishAlbumTopView.frame.origin.y + _publishAlbumTopView.frame.size.height + 10;
    _addressView.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, _addressView.frame.size.height + _addressView.frame.origin.y);
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
    
    [ToastManager showToast:@"已经超出上传图片数量！" containerView:_picker.view withTime:Toast_Hide_TIME];
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

#pragma mark - UIBarButtonItem
- (void)onPublishBtn:(UIBarButtonItem *)sender{
    
    
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    NSDictionary *dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_PUBLISH_SELECTADRESS withContext:dic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:nil];
    UIView *superView = self.view;
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(superView);
    }];
    
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left);
        make.top.mas_equalTo(_scrollView.mas_top);
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
        make.left.mas_equalTo(_scrollView.mas_left);
        make.top.mas_equalTo(_contentText.mas_bottom);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(@(40 + PublishImageTileHeight));
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left);
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

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = BGViewGray;
        [_scrollView addSubview:self.contentText];
        [_scrollView addSubview:self.publishAlbumTopView];
        [_scrollView addSubview:self.addressView];
    }
    return _scrollView;
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
        _publishAlbumTopView.delegate = self;
        _publishAlbumTopView.imageMaxCount = 8;
        if (self.assetName != nil) {
            
            ALAssetsLibrary *lib = [[ALAssetsLibrary alloc]init];
            [lib assetForURL:[NSURL URLWithString:self.assetName] resultBlock:^(ALAsset *asset) {
                
                [_publishAlbumTopView addImgUrls:@[asset]];
                
            } failureBlock:^(NSError *error) {
                
            }];
        }else{
            
             [_publishAlbumTopView addImgUrls:_assets];
        }

       
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

IMPLEMENT_MESSAGE_ROUTABLE

@end
