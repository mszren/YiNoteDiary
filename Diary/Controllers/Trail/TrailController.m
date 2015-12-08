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

@interface TrailController () <MAMapViewDelegate>

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
    self.title = @"发现";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsCompass = NO;//指南针
    _mapView.showsScale = NO;//比例尺
    _mapView.layer.shouldRasterize = YES;
    [_mapView setZoomLevel:13 animated:YES];
    
    //初始中心点
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.818884, 117.221945);
    MACoordinateSpan span = MACoordinateSpanMake(0.1, 0.1);
    _region = MACoordinateRegionMake(coordinate, span);
    [_mapView setRegion:_region];
    
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
}

@end
