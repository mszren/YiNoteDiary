//
//  IndexController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IndexController.h"
#import "PublishController.h"
#import "ActivityController.h"
#import "NearController.h"
#import "RemindController.h"
#import "SegmentView.h"
#import "ContentView.h"
#import "BaseNavigation.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "UzysAssetsPickerController.h"

@interface IndexController() <SegmentDelegate,DBCameraViewControllerDelegate,UzysAssetsPickerControllerDelegate>
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) SegmentView *barView;
@property (nonatomic, strong) ContentView *contentView;
@property (nonatomic,strong)UzysAssetsPickerController* picker;

@end

@implementation IndexController{
    
    UITableView* _tableView;
    UIBarButtonItem* _rightButton;
    PublishController *_publishVc;
    DBCameraViewController *_cameraController;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *captions = @[@"动态", @"附近",@"推荐"];
    _barView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, TabBarWidth, TabBarHeigh) andItems:captions];
    _barView.clickDelegate = self;
    self.navigationItem.titleView = _barView;
    
    ActivityController *activityVc = [ActivityController new];
    [self addChildViewController:activityVc];
    
    NearController *nearVc = [NearController new];
    [self addChildViewController:nearVc];
    
    RemindController *remindVc = [RemindController new];
    [self addChildViewController:remindVc];
    
    NSArray *controllers = @[activityVc,nearVc,remindVc];
    _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) andControllers:controllers];
    _contentView.swipeDelegate = self;
    [self.view addSubview:_contentView];
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
}

//改变按钮状态
- (void)changeRightItem:(int)segmentIndex{
    switch (segmentIndex) {
        case 0:
            self.navigationItem.rightBarButtonItem = _rightButton;
            break;
            
        default:
            self.navigationItem.rightBarButtonItem = nil;
            break;
    }
}

#pragma mark -- SegmentDelegate
- (void)contentSelectedSegmentIndexChanged:(int)segmentIndex {
    _currentIndex = segmentIndex;
    [_barView setCurrentSegmentBaeIndex:segmentIndex];
    [self changeRightItem:_currentIndex];
}

- (void)barSegmentIndexChanged:(int)segmentIndex {
    _currentIndex = segmentIndex;
    [_contentView setCurrentTableViewIndex:segmentIndex];
    [self changeRightItem:_currentIndex];
}

#pragma mark - DBCameraViewControllerDelegate

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    NSData * data = UIImageJPEGRepresentation(image, 0.08f);
    UIImage * temp = [[UIImage alloc] initWithData:data];
    PublishController *publishVc = [PublishController new];
    publishVc.hidesBottomBarWhenPushed = YES;
    publishVc.assets = [[NSMutableArray alloc]initWithCapacity:0];
    [publishVc.assets addObject:temp];
    [self.navigationController pushViewController:publishVc animated:YES];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        PublishController *publishVc = [PublishController new];
        publishVc.hidesBottomBarWhenPushed = YES;
        publishVc.assets = [[NSMutableArray alloc]initWithArray:assets];
        [self.navigationController pushViewController:publishVc animated:YES];
    }
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}


#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _cameraController = [DBCameraViewController initWithDelegate:self];
        [_cameraController setForceQuadCrop:YES];
        
        DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
        [container setCameraViewController:_cameraController];
        [container setFullScreenMode];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
        [nav setNavigationBarHidden:YES];
        [self presentViewController:nav animated:YES completion:nil];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _picker = [[UzysAssetsPickerController alloc] init];
        _picker.maximumNumberOfSelectionVideo = 0;
        _picker.maximumNumberOfSelectionPhoto = 4;
        _picker.delegate = self;
        [self presentViewController:_picker
                           animated:YES
                         completion:^{
                             
                         }];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
      [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:nil];
}

@end
