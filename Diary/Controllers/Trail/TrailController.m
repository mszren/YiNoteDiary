//
//  TrailController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "TrailController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchServices.h>
#import "EGOImageView.h"
#import "Masonry.h"
#import "QueueView.h"
#import "UIImage+ImageEffects.h"
#import "BaseNavigation.h"
#import "CusAnnotationView.h"
#import "MyTrailController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "IdentifyController.h"

#import "POIAnnotation.h"
#import "CommonUtility.h"
#import "TravleMapLine.h"
#import "TravelMapPointAnnotation.h"
#import "MWPhotoBrowser.h"
#import "NSDate_TimeZone.h"
#import "LocationManager.h"
#import "CustomAnnotationView.h"

#define kCalloutViewMargin          -8

@interface TrailController () <MAMapViewDelegate,DBCameraViewControllerDelegate,MWPhotoBrowserDelegate>

@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, strong) MAMapView *mapView;

@end

@implementation TrailController{
    
    MACoordinateRegion _region;//中心点坐标
    DBCameraViewController *_cameraController;
    UIImage *_cameraImg;
    
    CLLocation * _currentLocation;
    TravelEntity * _selectedTravelEntity;
}
@synthesize messageListner;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initMapView];
    [self creatSelectImg];
}

#pragma mark - DBCameraViewControllerDelegate

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    NSData * data = UIImageJPEGRepresentation(image, 0.08f);
    UIImage * temp = [[UIImage alloc] initWithData:data];
    _cameraImg = temp;
    NSDictionary * dic = @{ACTION_Controller_Name : self,ACTION_Controller_Data : _cameraImg};
    [self RouteMessage:ACTION_SHOW_IDENTIFY withContext:dic];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

#pragma mark -
#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  _selectedTravelEntity.imageList.count;
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    PhotoEntity * model = [_selectedTravelEntity.imageList objectAtIndex:index];
    MWPhoto * mwPhoto = [[MWPhoto alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadImgPath:model.photoImgPath]]];
    
    return mwPhoto;
}


#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
}

- (MAOverlayView *)mapView:(MAMapView *)mapView
            viewForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[TravleMapLine class]]) {
        TravleMapLine * travleMapLine = (TravleMapLine*)overlay;
        
        MAPolylineView *polylineView =
        [[MAPolylineView alloc] initWithPolyline:travleMapLine];
        polylineView.lineWidth = 10.f;
        polylineView.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        switch (travleMapLine.index) {
            case 0:{
                polylineView.strokeColor = [UIColor redColor];
                break;
            }
            case 1:{
                polylineView.strokeColor = [UIColor yellowColor];
                break;
            }
            case 2:{
                polylineView.strokeColor = [UIColor blueColor];
                break;
            }
            default:{
                polylineView.strokeColor = [UIColor blackColor];
                break;
            }
        }
        return polylineView;
    }
    return nil;
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        TravelMapPointAnnotation * temp = (TravelMapPointAnnotation *)annotation;
        static NSString *customReuseIndetifier = @"trailVcCustomReuseIndetifier";
        
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
        
       annotationView.portrait = [[UIImage alloc] initWithContentsOfFile:[[TravelImageCacheManage shareInstance] loadImgPath:temp.photoEntity.photoImgPath]];
        annotationView.index = temp.index;
        annotationView.name =  [NSString stringWithFormat:@"%lu",(unsigned long)temp.index];
        annotationView.travelEntity = temp.travelEntity;
        annotationView.photoEntity = temp.photoEntity;
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
        //取出当前位置的坐标
        NSLog(@"MAMapView latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:{
    
            [[TravelDataManage shareInstance] updateAllTravelFinish];
            
            TravelEntity * aModel = [[TravelEntity alloc] initWithName:@"北京" logo:@"北京" travelDesc:@"北京__故宫"];
            aModel.createTime = [NSDate currentTime];
            aModel.startLatitude = [LocationManager shareInstance].currentCoord.latitude;
            aModel.startLongitude = [LocationManager shareInstance].currentCoord.longitude;
            
            if ([[TravelDataManage shareInstance] insertTravelEnity:aModel]) {
                TravelEntity * temp = [[TravelDataManage shareInstance] selectTravelEntityByuuid:aModel.uuid];
                NSDictionary *dic = @{ACTION_Controller_Name : self,ACTION_Controller_Data : @{CurrentTravelEntity : temp, IsShowMember : @NO }};
                [self RouteMessage:ACTION_SHOW_MYTRAIL withContext:dic];
            }
        }
            
            break;
        case 101:{
            
            [self openCamer];
        }
            
            break;
        case 102:{
            [[QueueView sharedInstance] showQueueView:@"木子李" andTitle:@"我在行走的路上--跟我一起去欣赏美丽神秘的地方"];
            [QueueView sharedInstance].messageListner = self;
        }
            
            break;
            
        default:{
            
            [self openCamer];

        }
            break;
    }
}

#pragma mark - UITapGestureRecognizer
- (void)onAnnotationViewTap:(UITapGestureRecognizer *)sender{
    if ([sender.view isKindOfClass:[CusAnnotationView class]]) {
        
        CusAnnotationView *cusView = (CusAnnotationView *)sender.view;
        
        _selectedTravelEntity = cusView.travelEntity;
        if (_selectedTravelEntity.imageList.count) {
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            [browser setCurrentPhotoIndex:cusView.index];
            [self.navigationController pushViewController:browser animated:YES];
        }
    }
}

#pragma mark - Initialization

- (void)openCamer{
    
    _cameraController = [DBCameraViewController initWithDelegate:self];
    [_cameraController setForceQuadCrop:YES];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:_cameraController];
    [container setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)initMapView
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,  0, Screen_Width, Screen_height-TabBarHeight)];
    self.mapView.delegate = self;
    self.mapView.backgroundColor = [UIColor clearColor];
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    //自定义定位经度圈样式
    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;

    [self.mapView setZoomLevel:18.0 animated:YES];
    [self.view addSubview:self.mapView];
}

- (void)initLine{
    
    
    for (int i =0; i < _dataList.count; i++) {
        TravelEntity * aTravelEntity = [_dataList objectAtIndex:i];
        
        CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(aTravelEntity.travelRouteList.count * sizeof(CLLocationCoordinate2D));
        
        for (int j =0; j<aTravelEntity.travelRouteList.count; j++) {
            LocationEntity * locationEntity = [aTravelEntity.travelRouteList objectAtIndex:j];
            
            coordinates[j].longitude = locationEntity.longitude;
            coordinates[j].latitude  = locationEntity.latitude;
        }
        
        TravleMapLine *polyline = [TravleMapLine polylineWithCoordinates:coordinates count:aTravelEntity.travelRouteList.count];
        polyline.travelEntity =aTravelEntity;
        polyline.index = i;
        
        [self.mapView addOverlay:polyline];
        
        free(coordinates);
        coordinates = NULL;
    }
}

- (void)initAnnotation{
    
    for (int i =0; i < _dataList.count; i++) {
        TravelEntity * travelEntity = [_dataList objectAtIndex:i];
        
        for (int j =0; j<travelEntity.imageList.count; j++) {
            PhotoEntity * photoEntity = [travelEntity.imageList objectAtIndex:j];
            
            TravelMapPointAnnotation *pointAnnotation = [[TravelMapPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(photoEntity.latitude, photoEntity.longitude);
            
            pointAnnotation.title = photoEntity.photoImgPath;
            pointAnnotation.subtitle = travelEntity.travelID;
            
            pointAnnotation.travelEntity = travelEntity;
            pointAnnotation.index = j;
            pointAnnotation.photoEntity = photoEntity;
            [self.mapView addAnnotation:pointAnnotation];
        }
    }
    
    self.mapView.showsUserLocation = YES;
}



- (void)creatSelectImg{
    
    NSArray *titleArry = @[@"开始记录",@"拍照",@"组队",@"拍照识别"];
    NSArray *imgArry = @[@"ic_start recording@3x",@"ic_photograph@3x",@"ic_team@3x",@"ic_recognition@3x"];
    for (NSInteger i = 0; i < titleArry.count; i ++) {
        EGOImageView *img = [[EGOImageView alloc]initWithImage:[UIImage imageNamed:imgArry[i]]];
        [self.view addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right).offset(-20);
            make.top.mas_equalTo(self.view.mas_top).offset(27 + 71*i);
            make.width.mas_equalTo(@115);
            make.height.mas_equalTo(@54);
        }];
        img.tag = 100 + i;
        img.userInteractionEnabled = YES;
        
        
        UILabel *titleLabel = [UILabel new];
        [img addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(img.mas_right);
            make.top.mas_equalTo(img.mas_top);
            make.height.mas_equalTo(img.mas_height);
            make.width.mas_equalTo(@80);
        }];
        titleLabel.text = titleArry[i];
        titleLabel.font = FONT_SIZE_15;
        titleLabel.textColor = BGViewColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    EGOImageView *recordImg = (EGOImageView *)[self.view viewWithTag:100];
    UITapGestureRecognizer *recordTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [recordImg addGestureRecognizer:recordTap];
    
    EGOImageView *photoImg = (EGOImageView *)[self.view viewWithTag:101];
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [photoImg addGestureRecognizer:photoTap];
    
    EGOImageView *teamImg = (EGOImageView *)[self.view viewWithTag:102];
    UITapGestureRecognizer *teamTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [teamImg addGestureRecognizer:teamTap];
    
    EGOImageView *recognitImg = (EGOImageView *)[self.view viewWithTag:103];
    UITapGestureRecognizer *recognitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [recognitImg addGestureRecognizer:recognitTap];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"path %@",path);
    
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:@"我的轨迹"];
    [_dataList removeAllObjects];
    _dataList = [[TravelDataManage shareInstance] loadTravelListData];
    [self initLine];
    [self initAnnotation];
}

IMPLEMENT_MESSAGE_ROUTABLE
@end
