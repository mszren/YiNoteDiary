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
#import "UIImage+ImageEffects.h"
#import "BaseNavigation.h"
#import "RecordView.h"
#import "MWPhotoBrowser.h"
#import "PictureSaveController.h"
#import "MyAlbumController.h"

#import "TravelDBManager.h"
#import "TravelAdapterKeys.h"
#import "POIAnnotation.h"
#import "CusAnnotationView.h"
#import "TravleMapLine.h"
#import "TravelMapPointAnnotation.h"
#import "NSDate_TimeZone.h"

#define kCalloutViewMargin          -8

@interface MyTrailController () <MAMapViewDelegate,MWPhotoBrowserDelegate,RecordViewDelegate>

@end

@implementation MyTrailController{
    
    UIBarButtonItem* _rightButton;

    MWPhotoBrowser *_browser;
    MAUserLocation * _currentLocation;
    
    NSMutableArray * _pointList;
    NSMutableArray * _photoList;
    
    /**
     *  是否开始记录
     */
    BOOL _updateLocation;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initMapView];
    [self initLine];
    [self initAnnotation];
    [self initView];
}

- (void)initView{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"path %@",path);
    self.view.backgroundColor = BGViewColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _pointList = [[NSMutableArray alloc] initWithCapacity:0];
    _photoList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_pointList addObjectsFromArray:_currentTravelEntity.travelRouteList];
    [_photoList addObjectsFromArray:_currentTravelEntity.imageList];
    
    _updateLocation = NO;
    
    RecordView *recordView = [[RecordView alloc]initWithFrame:CGRectMake(0, Screen_height - 56 - NavigationBarHeight, Screen_Width, 56) andDelegate:self];
    recordView.memberBtn.hidden = !_isShowMember;
    recordView.viewController = self;
    [self.view addSubview:recordView];
    

}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,  0, Screen_Width, Screen_height-56)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.backgroundColor = [UIColor redColor];
    [self.mapView setZoomLevel:18.1 animated:YES];
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollowWithHeading animated:YES]; //地图跟着位置移动
    [self.view addSubview:self.mapView];
}


- (void)initAnnotation{
    for (int j =0; j<_photoList.count; j++) {
        PhotoEntity * photoEntity = [_photoList objectAtIndex:j];
        
        TravelMapPointAnnotation *pointAnnotation = [[TravelMapPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(photoEntity.latitude, photoEntity.longitude);
        
        pointAnnotation.title = photoEntity.photoImgPath;
        pointAnnotation.subtitle = _currentTravelEntity.travelID;
        
        pointAnnotation.travelEntity = _currentTravelEntity;
        pointAnnotation.index = j;
        pointAnnotation.photoEntity = photoEntity;
        [self.mapView addAnnotation:pointAnnotation];
    }
}


- (void)initLine{
    [self.mapView.layer removeAllAnimations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(_pointList.count * sizeof(CLLocationCoordinate2D));
    
    for (int i =0; i <_pointList.count; i ++) {
        LocationEntity * locationEntity = [_pointList objectAtIndex:i];
        
        coordinates[i].longitude = locationEntity.longitude;
        coordinates[i].latitude  = locationEntity.latitude;
    }
    TravleMapLine *polyline = [TravleMapLine polylineWithCoordinates:coordinates count:_pointList.count];
    [self.mapView addOverlay:polyline];
    
    free(coordinates);
    coordinates = NULL;
}

#pragma mark - MAMapViewDelegate

- (MAOverlayView *)mapView:(MAMapView *)mapView
            viewForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[TravleMapLine class]]) {
        MAPolylineView *polylineView =
        [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 10.f;
        
        polylineView.lineJoinType = kCGLineJoinRound;//连接类型
        polylineView.lineCapType = kCGLineCapRound;//端点类型
        
        polylineView.strokeColor = [UIColor redColor];
        
        
        return polylineView;
    }
    return nil;
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        TravelMapPointAnnotation * temp = (TravelMapPointAnnotation *)annotation;
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout   = NO;
            annotationView.draggable        = YES;
            annotationView.calloutOffset    = CGPointMake(0, -5);
        }
        
        annotationView.portrait = [[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadSmallImgPath:temp.photoEntity.photoImgPath]];
        annotationView.travelEntity = temp.travelEntity;
        annotationView.photoEntity = temp.photoEntity;
        annotationView.index = temp.index;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CusAnnotationView class]]) {
        
        CusAnnotationView *cusView = (CusAnnotationView *)view;
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        [browser setCurrentPhotoIndex:cusView.index];
        [self.navigationController pushViewController:browser animated:YES];
        
    }
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation && _updateLocation)
    {
        CLLocation *orig= userLocation.location;
        CLLocation* dist= _currentLocation.location;
        
        
        CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
        NSLog(@"距离:%f==latitude=%f==longitude=%f",kilometers,userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        LocationEntity * locationEntity = [[LocationEntity alloc] initWithTravelID:_currentTravelEntity.travelID latitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        locationEntity.createTime = [NSDate currentTime];
        [[TravelDataManage shareInstance] insertLocationEnity:locationEntity];
        
        _currentLocation = userLocation;
        
        [_pointList addObject:locationEntity];
        
        [self initLine];

    }
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  _photoList.count;
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    PhotoEntity * model = [_photoList objectAtIndex:index];
    MWPhoto * photo = [[MWPhoto alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadImgPath:model.photoImgPath]]];
    photo.caption = @"把你想说的话写下来吧...";
    photo.captionAdress = @"上海东方明珠";
    photo.captionTime = @"2015-06-08 09:30";
    photo.isUserInterAction = YES;
    return photo;
}

#pragma mark -- RecordViewDelegate
- (void)recordViewDelegateFinishTrail{
    
    
    _updateLocation = NO;
    _rightButton.enabled = YES;
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"生成专辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MyAlbumController *myAlbumVc = [MyAlbumController new];
        myAlbumVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myAlbumVc animated:YES];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"保存足迹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[TravelDataManage shareInstance] updateTravelFinish:_currentTravelEntity.travelID];
        
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

- (void)recordViewDelegateReturnPhoto:(UIImage *)image{
    
    TravelImageCacheManage * travelImageCacheManage = [TravelImageCacheManage  shareInstance];
    NSString * urlPath = [travelImageCacheManage saveImage:image withType:ETravleType];
    
    
    PhotoEntity * aModel = [[PhotoEntity alloc] initWithTravelID:_currentTravelEntity.travelID latitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    aModel.createTime = [NSDate currentTime];
    aModel.photoImgPath = urlPath;
    
    [[TravelDataManage shareInstance] insertPhotoEnity:aModel];
    
    [_photoList addObject:aModel];
    
    
    TravelMapPointAnnotation *pointAnnotation = [[TravelMapPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(aModel.latitude, aModel.longitude);
    
    pointAnnotation.title = aModel.photoImgPath;
    pointAnnotation.subtitle = aModel.travelID;
    pointAnnotation.travelEntity = _currentTravelEntity;
    pointAnnotation.index = _photoList.count-1;
    pointAnnotation.photoEntity = aModel;
    [self.mapView addAnnotation:pointAnnotation];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
   
    [ToastManager showToast:@"开始轨迹记录！" containerView:self.view withTime:Toast_Hide_TIME];
    _updateLocation = YES;
    _rightButton.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的轨迹"];
}

@end
