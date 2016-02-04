//
//  OtherTrailController.m
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "OtherTrailController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchServices.h>
#import "EGOImageView.h"
#import "Masonry.h"
#import "UIImage+ImageEffects.h"
#import "BaseNavigation.h"
#import "CusAnnotationView.h"
#import "OtherTrailView.h"
#import "MWPhotoBrowser.h"

#import "TravelDBManager.h"
#import "TravelAdapterKeys.h"
#import "POIAnnotation.h"
#import "CusAnnotationView.h"
#import "TravleMapLine.h"
#import "TravelMapPointAnnotation.h"
#import "NSDate_TimeZone.h"

#define kCalloutViewMargin          -8

@interface OtherTrailController () <MAMapViewDelegate,MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *overlaysAboveRoads;
@property (nonatomic, strong) NSMutableArray *overlaysAboveLabels;
@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation OtherTrailController{
    
    MACoordinateRegion _region;//中心点坐标
    UIBarButtonItem* _rightButton;
    OtherTrailView *_otherTrailView;
    
    MWPhotoBrowser *_browser;
    MAUserLocation * _currentLocation;
    
    NSMutableArray * _pointList;
    NSMutableArray * _photoList;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self initMapView];
    [self initLine];
    [self initAnnotation];
}

- (void)initView{
    self.view.backgroundColor = BGViewColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _pointList = [[NSMutableArray alloc] initWithCapacity:0];
    _photoList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_pointList addObjectsFromArray:_currentTravelEntity.travelRouteList];
    [_photoList addObjectsFromArray:_currentTravelEntity.imageList];
    
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,  0, Screen_Width, Screen_height)];
    self.mapView.delegate = self;
    self.mapView.backgroundColor = [UIColor redColor];
    [self.mapView setZoomLevel:18.1 animated:YES];
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)]];
    [self.view addSubview:self.mapView];
    
    _otherTrailView = [[OtherTrailView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 180)];
    [_otherTrailView setName:@"木子李" andContent:@"当前拍摄了10张照片" andImage:[UIImage imageNamed:@"pic_bg"]];
    [self.view addSubview:_otherTrailView];
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
        
        annotationView.portrait = [[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadSmallImgPath:temp.photoEntity.photoImgPath]];
        annotationView.name =  [NSString stringWithFormat:@"%lu",(unsigned long)temp.index];
        annotationView.travelEntity = temp.travelEntity;
        annotationView.photoEntity = temp.photoEntity;
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

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    [_otherTrailView setHidden:NO];
}

- (void)onTap{
    [_otherTrailView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
       [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"TA的轨迹"];
}

@end
