//
//  NearPictureController.m
//  Diary
//
//  Created by 我 on 15/12/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "NearPictureController.h"
#import "BaseNavigation.h"
#import "AZXCollectionViewPubuLayout.h"
#import "NearPictureCell.h"
#import "MWPhotoBrowser.h"

@interface NearPictureController () <UICollectionViewDataSource,AZXCollectionViewPubuLayoutDelegate,UICollectionViewDelegate,MWPhotoBrowserDelegate>

@end

@implementation NearPictureController{
    
    UICollectionView *_collectionView;
    NSMutableArray *_imgArry;
    NSMutableArray *_photos;
    MWPhotoBrowser *_browser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    AZXCollectionViewPubuLayout *layout = [[AZXCollectionViewPubuLayout alloc] init];
    layout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = BGViewColor;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[NearPictureCell class] forCellWithReuseIdentifier:NearPictureCellIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    _imgArry = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i = 0; i < 20; i++) {
        [_imgArry addObject:[UIImage imageNamed:@"pic_bg"]];
    }
    
    _photos = [[NSMutableArray alloc]initWithCapacity:0];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHeight = 70 + (arc4random() % 140);
    return randomHeight;
}

- (CGFloat)colMarginForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return 10;
}

- (CGFloat)rowMarginForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return 10;
}

- (UIEdgeInsets)edgeInsetsForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NearPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:NearPictureCellIdentifier forIndexPath:indexPath];
    [pictureCell bindImg:(UIImage *)_imgArry[indexPath.row]];
//    pictureCell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return pictureCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self openPhotoBrower:indexPath.row];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"附近照片"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
