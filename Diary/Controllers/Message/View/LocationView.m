//
//  LocationView.m
//  Diary
//
//  Created by 我 on 15/12/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "LocationView.h"
#import "Masonry.h"

@implementation LocationView

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)showLocationView:(NSDictionary *)locationDic{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = YES;
    
    _viewController = [[UIViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:_viewController];
    
    self.window.rootViewController = navc;
    
    [self initNavigationBar];

    _viewController.edgesForExtendedLayout = UIRectEdgeNone;
   
    _mapView = [MKMapView new];
    [_viewController.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.mas_equalTo(_viewController.view);
        make.height.mas_equalTo(Screen_height - NavigationBarHeight);
    }];
    _mapView.delegate = self;
    _mapView.showsBuildings = YES;
    _mapView.showsUserLocation = YES;
    _mapView.showsCompass = YES;
    _mapView.showsScale = YES;
    _mapView.mapType = MKMapTypeStandard;
   CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([locationDic[@"latitude"] floatValue], [locationDic[@"longitude"] floatValue]);;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region];//指定地图的显示范围。
    MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
    pin.coordinate = coordinate;
    pin.title = locationDic[@"address"];
    [_mapView addAnnotation:pin];
 
    // The window has to be un-hidden on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.window makeKeyAndVisible];
        
        _mapView.alpha = 0;
        _mapView.layer.shouldRasterize = YES;
        _mapView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            
            _mapView.alpha = 1;
            _mapView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            _mapView.layer.shouldRasterize = NO;
        }];
        
    });
    
    
}

- (void)initNavigationBar{
    
    [_viewController.navigationController.navigationBar setBarTintColor:BGViewGreen];
    _viewController.navigationController.navigationBar.alpha = 1.0;
    [_viewController.navigationController.navigationBar setTranslucent:NO];
    [_viewController.navigationController.navigationBar setTintColor:BGViewColor];
    
    //去除导航栏描边黑线
    [_viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [_viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, 44)];
    titleLab.textColor = BGViewColor;
    titleLab.font = BOLDFont_SIZE_19;
    titleLab.text = @"位置分享";
    titleLab.textAlignment = NSTextAlignmentCenter;
    _viewController.navigationItem.titleView = titleLab;
    
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_return"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(leftItemAction:)];
    _viewController.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -- MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifer = @"MyPinId";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifer];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifer];
        pinView.canShowCallout = YES;//点大头针时是否弹出提示
        
    } else {
        pinView.annotation = annotation;
        
    }
    return pinView;
}

#pragma mark -- UIBarButtonItem Action
- (void)leftItemAction:(UIBarButtonItem *)sender{
    [self clean];
}

-(void)clean{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _mapView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _mapView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            self.window.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            [self.window removeFromSuperview];
            [self.mapView removeFromSuperview];
            self.viewController = nil;
            self.window = nil;
            
        }];
        
    });
}

@end
