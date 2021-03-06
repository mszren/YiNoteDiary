//
//  NearFeatureController.m
//  Diary
//
//  Created by 我 on 15/11/16.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "NearFeatureController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchServices.h>
#import "CusAnnotationView.h"
#import "FeatureListController.h"
#import "BaseNavigation.h"
#import "FeatureDetailController.h"

#define kCalloutViewMargin          -8

@interface NearFeatureController () <MAMapViewDelegate>
@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation NearFeatureController{
    
     MAMapView *_mapView;
    MACoordinateRegion _region;//中心点坐标
    UIBarButtonItem* _rightButton;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = NO;//指南针
    _mapView.showsScale = NO;//比例尺
    _mapView.layer.shouldRasterize = YES;
     [_mapView setZoomLevel:11 animated:YES];
    
    //初始中心点
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.992520, 116.336170);
    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
    _region = MACoordinateRegionMake(coordinate, span);
    [_mapView setRegion:_region];
    
    self.annotations = [NSMutableArray array];
    
    CLLocationCoordinate2D coordinates[8] = {
        {39.992520, 116.336170},
        {39.992520, 116.336170},
        {39.998293, 116.352343},
        {40.004087, 116.348904},
        {39.989098, 116.360200},
        {39.998439, 116.360201},
        {39.979590, 116.324219},
        {39.978234, 116.352792}};
    
    for (int i = 0; i < 8; i++)
    {
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = coordinates[i];
        annotation.title      = [NSString stringWithFormat:@"anno: %d", i];
        [self.annotations addObject:annotation];
    }
    
    [_mapView addAnnotations:self.annotations];
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"featureReuseIndetifier";
        
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
        [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)]];
        
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

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    NSDictionary *dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_NEAR_FEARTURE_LIST withContext:dic];
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{

    NSDictionary *dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_NEAR_FEARTURE_DETAIL withContext:dic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"附近景点"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE

@end
