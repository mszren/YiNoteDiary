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
#import "IdentifyController.h"
#import "UIImage+ImageEffects.h"
#import "BaseNavigation.h"

@interface TrailController () <MAMapViewDelegate>
@property (nonatomic, strong) NSMutableArray *overlaysAboveRoads;
@property (nonatomic, strong) NSMutableArray *overlaysAboveLabels;

@end

@implementation TrailController{
    
    MAMapView *_mapView;
    MACoordinateRegion _region;//中心点坐标
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = NO;//指南针
    _mapView.showsScale = NO;//比例尺
    _mapView.layer.shouldRasterize = YES;
    [_mapView setZoomLevel:13 animated:YES];
    
    //初始中心点
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
//    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
//    _region = MACoordinateRegionMake(coordinate, span);
//    [_mapView setRegion:_region];
    
    [self initOverlays];
    [self creatSelectImg];

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
        polylineView.lineWidth    = 15.f;
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
        //        polylineView.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
        //        polylineView.lineJoinType = kMALineJoinRound;//连接类型
        //        polylineView.lineCapType = kMALineCapArrow;//端点类型
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:{
            [[QueueView sharedInstance] showQueueView:@"木子李" andTitle:@"我在行走的路上--跟我一起去欣赏美丽神秘的地方" withViewController:self];
        }
            
            break;
            
        default:{
            IdentifyController *identifyVc = [IdentifyController new];
            identifyVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:identifyVc animated:YES];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:@"我的轨迹"];
}

@end
