//
//  PersonCenterController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PersonCenterController.h"
#import "BaseNavigation.h"
#import "UzysAssetsPickerController.h"
#import <Photos/Photos.h>
#import "DBCameraViewController.h"
#import "SPKitExample.h"

typedef enum : NSUInteger {
    kActionSheetTagLogout,
    kActionSheetTagEnvironment,
} kActionSheetTag;

@interface PersonCenterController () <UzysAssetsPickerControllerDelegate,DBCameraViewControllerDelegate,UIActionSheetDelegate>

@end

@implementation PersonCenterController{
    
    UzysAssetsPickerController *_picker;
    UIImage *_selectImg;
    NSMutableArray *_selectArry;
    DBCameraViewController *_cameraController;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
   
    _selectArry = [[NSMutableArray alloc]initWithCapacity:0];
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.outBtn.frame.size.height + self.outBtn.frame.origin.y + 10);
    
    self.faceView.userInteractionEnabled = YES;
    UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    self.faceImg.userInteractionEnabled = YES;
    [self.faceImg addGestureRecognizer:faceTap];
    
    UITapGestureRecognizer *nichengTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nichengView addGestureRecognizer:nichengTap];
    
    UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.signView addGestureRecognizer:signTap];
    
    UITapGestureRecognizer *sexTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.sexView addGestureRecognizer:sexTap];
    
    UITapGestureRecognizer *ageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.ageView addGestureRecognizer:ageTap];
    
    UITapGestureRecognizer *adressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.adressView addGestureRecognizer:adressTap];
    
    UITapGestureRecognizer *codeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.codeView addGestureRecognizer:codeTap];
    
    [self.outBtn addTarget:self action:@selector(onBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onBtn{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"退出后您将收不到新消息，是否确认退出?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出当前帐号" otherButtonTitles:nil];
    [as setTag:kActionSheetTagLogout];
    [as showInView:self.tabBarController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == kActionSheetTagLogout) {
        
        [[SPKitExample sharedInstance] callThisBeforeISVAccountLogout];
    }
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_EDIT withContext:dic];
        }
            
            break;
        case 101:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_SIGN withContext:dic];
        }
            
            break;
        case 102:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_SEX withContext:dic];
        }
            
            break;
        case 103:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_AGE withContext:dic];
        }
            
            break;
        case 104:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_PROVINCE withContext:dic];
        }
            
            break;
        case 105:{
            
            NSDictionary *dic = @{ACTION_Controller_Name : self};
            [self RouteMessage:ACTION_SHOW_MY_CODE withContext:dic];
        }
            
            break;
        default:{
            
            [self creatAlertView];
        }
            break;
    }
}

- (void)creatAlertView{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        _cameraController =
        [DBCameraViewController initWithDelegate:self];
        [_cameraController setUseCameraSegue:NO];
        UINavigationController *nav = [[UINavigationController alloc]
                                       initWithRootViewController:_cameraController];
        [nav setNavigationBarHidden:YES];
        [self presentViewController:nav animated:YES completion:nil];

    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"图库上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        _picker = [[UzysAssetsPickerController alloc] init];
        _picker.maximumNumberOfSelectionVideo = 0;
        _picker.maximumNumberOfSelectionPhoto = 1;
        _picker.delegate = self;
        _picker.selectedAssetArray = _selectArry;
        
        [self presentViewController:_picker
                           animated:YES
                         completion:^{
                             
                         }];
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        ALAsset *asset = assets[0];
        _selectImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        _faceImg.image = _selectImg;
        [_selectArry removeAllObjects];
        [_selectArry addObject:asset];
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    NSData * data = UIImageJPEGRepresentation(image, 0.08f);
    UIImage * temp = [[UIImage alloc] initWithData:data];
    _selectImg = temp;
    _faceImg.image = _selectImg;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"个人中心"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMPLEMENT_MESSAGE_ROUTABLE

@end
