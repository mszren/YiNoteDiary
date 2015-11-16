//
//  PublishAlbumTopView.m
//  Lvguotou
//
//  Created by 曹亮 on 15/5/25.
//  Copyright (c) 2015年 Lvguotou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PublishAlbumTopView.h"

#import "AlbumImageTileView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "Header.h"
#define ImageMaxCount 3
@interface PublishAlbumTopView () <AlbumImageTileViewDelegate> {

    UIImageView* _btn_add;
    NSInteger _height ;
}
@end

@implementation PublishAlbumTopView
@synthesize dataList = _dataList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataList = [[NSMutableArray alloc] initWithCapacity:0];
        _height = PublishImageTileHeight + 48;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setViewDefault
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PublishImageTileHeight + 20)];
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    _btn_add = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_publish"]];
    _btn_add.userInteractionEnabled = YES;
    _btn_add.frame = CGRectMake(20, 20, PublishImageTileWidth, PublishImageTileHeight);
    [_scrollView addSubview:_btn_add];
    UITapGestureRecognizer* _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_btn_add addGestureRecognizer:_tap];
}
- (void)tapAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showPickImgs:)]) {
        [self.delegate showPickImgs:_dataList];
    }
}

- (void)addImgUrls:(NSArray*)array
{
    [_dataList removeAllObjects];
    [_dataList addObjectsFromArray:array];
    [self initView];
}

- (void)initView
{
    NSArray* subView = self.subviews;
    for (int i = 0; i < subView.count; i++) {
        UIView* t = [subView objectAtIndex:i];
        if ([t isKindOfClass:[AlbumImageTileView class]]) {
            [t removeFromSuperview];
        }
    }

    if (_imageMaxCount == _dataList.count) {
        [_btn_add removeFromSuperview];
    }
    
    NSArray *subViews = _scrollView.subviews;
    for (UIView *v in subViews) {
        [v removeFromSuperview];
    }
    
    NSInteger num = _dataList.count + 1;
    float width = 20.0f;
//    float height = 20.0f;
    for (int i = 0; i < num; i++) {
        
//        if ((width + PublishImageTileWidth) > SCREEN_WIDTH) {
//            height += PublishImageTileHeight + 20;
//            width = 20.0f;
//        }
        
       if(i>=0 && i < num -1){
            
            AlbumImageTileView* tile = [[AlbumImageTileView alloc] initWithFrame:CGRectMake(width, 20, PublishImageTileWidth, PublishImageTileHeight)];
            tile.delegate = self;
            ALAsset* asset = (ALAsset*)[_dataList objectAtIndex:i];
            [tile setViewData:asset];
            [_scrollView addSubview:tile];
       }else if( i == num -1 && (_dataList.count < _imageMaxCount)){
           
           _btn_add.frame = CGRectMake(width, 20, _btn_add.frame.size.width, _btn_add.frame.size.height);
           [_scrollView addSubview:_btn_add];
           
       }
        
        width += PublishImageTileWidth + 20;
    }
    
    _scrollView.contentSize = CGSizeMake(width , 0);
//    
//    if ( height > 20) {
//        _height = height + PublishImageTileHeight + 20;
//    }else{
//        _height = PublishImageTileHeight + 48;
//    }
//    [self.delegate pickImgsViewHeight:_height];
    

//
//    NSInteger imageCount = _imageMaxCount == 0 ? ImageMaxCount : _imageMaxCount;
//    if (_dataList.count < imageCount) {
//        _btn_add.frame = CGRectMake(width, height, _btn_add.frame.size.width, _btn_add.frame.size.height);
//        if (_btn_add.superview == nil)
//            [self addSubview:_btn_add];
//    }
//    else if (_btn_add.superview != nil)
//        [_btn_add removeFromSuperview];
}
#pragma mark -
#pragma mark AlbumImageTileViewDelegate
- (void)removeImage:(ALAsset*)asset
{
    [_dataList removeObject:asset];
    [self initView];
}

@end
