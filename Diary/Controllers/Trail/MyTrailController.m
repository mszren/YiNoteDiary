//
//  MyTrailController.m
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "MyTrailController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchServices.h>
#import "EGOImageView.h"
#import "Masonry.h"
#import "UIImage+ImageEffects.h"
#import "BaseNavigation.h"
#import "CusAnnotationView.h"
#import "RecordView.h"
#import "MWPhotoBrowser.h"
#import "PictureSaveController.h"
#import "MyAlbumController.h"

#define kCalloutViewMargin          -8

@interface MyTrailController () <MAMapViewDelegate,MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *overlaysAboveRoads;
@property (nonatomic, strong) NSMutableArray *overlaysAboveLabels;
@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation MyTrailController{
    
    MAMapView *_mapView;
    MACoordinateRegion _region;//中心点坐标
    UIBarButtonItem* _rightButton;
    
    NSMutableArray *_imgArry;
    NSMutableArray *_photos;
    MWPhotoBrowser *_browser;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.view.backgroundColor = BGViewColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    RecordView *recordView = [[RecordView alloc]initWithFrame:CGRectMake(0, Screen_height - 56 - NavigationBarHeight, Screen_Width, 56)];
    recordView.memberBtn.hidden = !_isShowMember;
    recordView.viewController = self;
    [self.view addSubview:recordView];
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - 56)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = NO;//指南针
    _mapView.showsScale = NO;//比例尺
    _mapView.layer.shouldRasterize = YES;
    //    [_mapView setZoomLevel:13 animated:YES];
    
    
    [self initOverlays];
    
    //初始中心点
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.832136, 116.42095);
    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
    _region = MACoordinateRegionMake(coordinate, span);
    [_mapView setRegion:_region];
    
    self.annotations = [NSMutableArray array];
    
    CLLocationCoordinate2D coordinates[8] = {
        {39.793765, 116.294653},
        {39.831741, 116.294653},
        {39.832136, 116.42095},
        {39.832136, 116.42095},
        {39.902136, 116.42095},
        {39.902136, 116.44095},
        {39.932136, 116.44095},
        {39.952136, 116.50095}};
    
    for (int i = 0; i < 8; i++)
    {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = coordinates[i];
        annotation.title      = [NSString stringWithFormat:@"anno: %d", i];
        [self.annotations addObject:annotation];
    }
    
    [_mapView addAnnotations:self.annotations];
    
    
    _imgArry = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i = 0; i < 20; i++) {
        [_imgArry addObject:[UIImage imageNamed:@"pic_bg"]];
    }
    
    _photos = [[NSMutableArray alloc]initWithCapacity:0];
}


#pragma mark - Initialization
- (void)initOverlays
{
    self.overlaysAboveLabels = [NSMutableArray array];
    self.overlaysAboveRoads = [NSMutableArray array];
    
    /* Arrow Polyline.  构造折线数据对象 */
    CLLocationCoordinate2D ArrowPolylineCoords[8];
    ArrowPolylineCoords[0].latitude = 39.793765;
    ArrowPolylineCoords[0].longitude = 116.294653;
    
    ArrowPolylineCoords[1].latitude = 39.831741;
    ArrowPolylineCoords[1].longitude = 116.294653;
    
    ArrowPolylineCoords[2].latitude = 39.832136;
    ArrowPolylineCoords[2].longitude = 116.34095;
    
    ArrowPolylineCoords[3].latitude = 39.832136;
    ArrowPolylineCoords[3].longitude = 116.42095;
    
    ArrowPolylineCoords[4].latitude = 39.902136;
    ArrowPolylineCoords[4].longitude = 116.42095;
    
    ArrowPolylineCoords[5].latitude = 39.902136;
    ArrowPolylineCoords[5].longitude = 116.44095;
    
    ArrowPolylineCoords[6].latitude = 39.932136;
    ArrowPolylineCoords[6].longitude = 116.44095;
    
    ArrowPolylineCoords[7].latitude = 39.952136;
    ArrowPolylineCoords[7].longitude = 116.50095;
    
    for (NSInteger i = 0; i < 8; i++) {
        MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(ArrowPolylineCoords[i].latitude, ArrowPolylineCoords[i].longitude) radius:500];
        [self.overlaysAboveRoads addObject:circle];
    }
    
    //构造折线对象
    MAPolyline *arrowPolyline = [MAPolyline polylineWithCoordinates:ArrowPolylineCoords count:8];
    
    for (NSInteger i = 0; i < 8; i++) {
        [self.overlaysAboveLabels insertObject:arrowPolyline atIndex:i];
    }
    
    [_mapView addOverlays:self.overlaysAboveLabels];
    [_mapView addOverlays:self.overlaysAboveRoads level:MAOverlayLevelAboveRoads];
}

#pragma mark - MAMapViewDelegate

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth    = 5.f;
        circleView.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleView.fillColor    = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        circleView.lineDash     = YES;
        
        return circleView;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth    = 8.f;
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
        //        polylineView.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
        //        polylineView.lineJoinType = kMALineJoinRound;//连接类型
        //        polylineView.lineCapType = kMALineCapArrow;//端点类型
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:customReuseIndetifier];
        }
        
        // must set to NO, so we can show the custom callout view.
        annotationView.canShowCallout   = YES;
        annotationView.draggable        = YES;
        annotationView.calloutOffset    = CGPointMake(0, -5);
        [annotationView.portraitImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onAnnotationViewTap:)]];
        
        annotationView.portrait         = [UIImage imageNamed:@"pic_bg"];
        annotationView.name             = @"17";
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CusAnnotationView class]]) {
        CusAnnotationView *cusView = (CusAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:_mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(_mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:_mapView.frame];
            
            CGPoint screenAnchor = [_mapView getMapStatus].screenAnchor;
            CGPoint theCenter = CGPointMake(_mapView.bounds.size.width * screenAnchor.x, _mapView.bounds.size.height * screenAnchor.y);
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:theCenter toCoordinateFromView:_mapView];
            
            [_mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}

#pragma mark - Utility
- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//打开MWPhotoBrowser
- (void)openPhotoBrower:(NSInteger)selectRow{
    
    [_photos removeAllObjects];
    
    [_imgArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [MWPhoto photoWithImage:obj];
        photo.caption = @"行走在美丽的江南水乡行走在美丽的江南水乡行走在美丽的江南水乡";
        photo.captionAdress = @"上海东方明珠";
        photo.captionTime = @"2015-06-08 09:30";
        [_photos addObject:photo];
    }];
    
    _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _browser.displayActionButton = YES;
    _browser.displayNavArrows = YES;
    _browser.displaySelectionButtons = NO;
    _browser.alwaysShowControls = NO;
    _browser.zoomPhotosToFill = YES;
    _browser.enableGrid = YES;
    _browser.startOnGrid = YES;
    
    _browser.enableSwipeToDismiss = NO;
    _browser.autoPlayOnAppear = YES;
    [_browser setCurrentPhotoIndex:selectRow];
    [self.navigationController pushViewController:_browser animated:YES];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"生成专辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MyAlbumController *myAlbumVc = [MyAlbumController new];
        myAlbumVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myAlbumVc animated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"保存足迹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PictureSaveController *saveVc = [PictureSaveController new];
        saveVc.hidesBottomBarWhenPushed = YES;
        saveVc.saveTitleStr = @"把我的轨迹分享到";
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:saveVc animated:YES];

    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

- (void)onAnnotationViewTap:(UITapGestureRecognizer *)sender{
    
    [self openPhotoBrower:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的轨迹"];
}

@end
