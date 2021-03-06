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
#import "CustomAnnotationView.h"

#define kCalloutViewMargin          -8

@interface MyTrailController () <MAMapViewDelegate,MWPhotoBrowserDelegate,RecordViewDelegate>

@end

@implementation MyTrailController{
    
    UIBarButtonItem* _rightButton;

    MWPhotoBrowser *_browser;
    MAUserLocation * _currentLocation;
    
    NSMutableArray * _pointList;
    NSMutableArray * _photoList;
}
@synthesize messageListner;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"path %@",path);
    self.view.backgroundColor = BGViewColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"结束游记" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _pointList = [[NSMutableArray alloc] initWithCapacity:0];
    _photoList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_pointList addObjectsFromArray:_currentTravelRecord.travelRouteList];
    [_photoList addObjectsFromArray:_currentTravelRecord.imageList];
    
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
    
    RecordView *recordView = [[RecordView alloc]initWithFrame:CGRectMake(0, Screen_height - 56 - NavigationBarHeight, Screen_Width, 56) andDelegate:self];
    recordView.memberBtn.hidden = !_isShowMember;
    recordView.messageListner = self;
    recordView.viewController = self;
    [self.view addSubview:recordView];
}


- (void)initAnnotation{
    for (int j =0; j<_photoList.count; j++) {
        PhotoRecord * photoRecord = [_photoList objectAtIndex:j];
        
        TravelMapPointAnnotation *pointAnnotation = [[TravelMapPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(photoRecord.latitude, photoRecord.longitude);
        
        pointAnnotation.title = photoRecord.photoImgPath;
        pointAnnotation.subtitle = [NSString stringWithFormat:@"%@",_currentTravelRecord.travelID];
        
        pointAnnotation.travelRecord = _currentTravelRecord;
        pointAnnotation.index = j;
        pointAnnotation.photoRecord = photoRecord;
        [self.mapView addAnnotation:pointAnnotation];
    }
}

- (void)initLine{
    [self.mapView.layer removeAllAnimations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(_pointList.count * sizeof(CLLocationCoordinate2D));
    
    for (int i =0; i <_pointList.count; i ++) {
        LocationRecord * locationRecord = [_pointList objectAtIndex:i];
        
        coordinates[i].longitude = locationRecord.longitude;
        coordinates[i].latitude  = locationRecord.latitude;
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
        polylineView.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
//        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
        
        return polylineView;
    }
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        TravelMapPointAnnotation * temp = (TravelMapPointAnnotation *)annotation;
        static NSString *customReuseIndetifier = @"myTrailVcCustomReuseIndetifier";
        
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
        
        annotationView.portrait = [[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadSmallImgPath:temp.photoRecord.photoImgPath]];
        annotationView.name =  [NSString stringWithFormat:@"%lu",(unsigned long)temp.index];
        annotationView.travelRecord = temp.travelRecord;
        annotationView.photoRecord = temp.photoRecord;
        annotationView.index = temp.index;
        [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onAnnotationViewTap:)]];
        
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        CLLocation *orig= userLocation.location;
        CLLocation* dist= _currentLocation.location;
        
        
        CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
//        NSLog(@"距离:%f==latitude=%f==longitude=%f",kilometers,userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        LocationRecord * locationRecord = [[LocationRecord alloc] initWithTravelID:_currentTravelRecord.travelID latitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        locationRecord.createTime = [NSDate currentTime];
        [[LocationDatacenter shareInstance] insertLocationRecord:locationRecord];
        
        _currentLocation = userLocation;
        
        [_pointList addObject:locationRecord];
        
        [self initLine];

    }
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  _photoList.count;
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    PhotoRecord * model = [_photoList objectAtIndex:index];
    MWPhoto * photo = [[MWPhoto alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadImgPath:model.photoImgPath]]];
    photo.caption = @"把你想说的话写下来吧...";
    photo.captionAdress = @"上海东方明珠";
    photo.captionTime = @"2015-06-08 09:30";
    photo.isUserInterAction = YES;
    return photo;
}

#pragma mark -- RecordViewDelegate
- (void)recordViewDelegateFinishTrail{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"生成专辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary *dic = @{ACTION_Controller_Name : self};
        [self RouteMessage:ACTION_SHOW_MYALBUM withContext:dic];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"保存足迹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[TrailDataCenter shareInstance] updateTravelFinish:_currentTravelRecord.travelID];
        
        NSDictionary *dic = @{ACTION_Controller_Name : self ,ACTION_Controller_Data : @"把我的轨迹分享到"};
        [self RouteMessage:ACTION_SHOW_PICTURESAVE withContext:dic];
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)recordViewDelegateReturnPhoto:(UIImage *)image{
    
    TravelImageCacheManage * travelImageCacheManage = [TravelImageCacheManage  shareInstance];
    NSString * urlPath = [travelImageCacheManage saveImage:image withType:ETravleType];
    
    
    PhotoRecord * aModel = [[PhotoRecord alloc] initWithTravelID:_currentTravelRecord.travelID latitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    aModel.createTime = [NSDate currentTime];      
    aModel.photoImgPath = urlPath;
    aModel.latitude = _currentLocation.coordinate.latitude;
    aModel.longitude = _currentLocation.coordinate.longitude;
    
    [[PhotoDataCenter shareInstance] insertPhotoRecord:aModel];
    
    [_photoList addObject:aModel];
    
    
    TravelMapPointAnnotation *pointAnnotation = [[TravelMapPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(aModel.latitude, aModel.longitude);
    
    pointAnnotation.title = aModel.photoImgPath;
    pointAnnotation.subtitle = [NSString stringWithFormat:@"%@",aModel.travelID];
    pointAnnotation.travelRecord = _currentTravelRecord;
    pointAnnotation.index = _photoList.count-1;
    pointAnnotation.photoRecord = aModel;
    [self.mapView addAnnotation:pointAnnotation];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
   
    if ([[TrailDataCenter shareInstance] updateTravelFinish:_currentTravelRecord.travelID]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)onAnnotationViewTap:(UITapGestureRecognizer *)sender{
    /* Adjust the map center in order to show the callout view completely. */
    if ([sender.view isKindOfClass:[CusAnnotationView class]]) {
        
        CusAnnotationView *cusView = (CusAnnotationView *)sender.view;
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        [browser setCurrentPhotoIndex:cusView.index];
        [self.navigationController pushViewController:browser animated:YES];
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的轨迹"];
    [self initMapView];
    [self initLine];
    [self initAnnotation];
}

IMPLEMENT_MESSAGE_ROUTABLE

@end
