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

@interface PublishAlbumTopView () <AlbumImageTileViewDelegate>
@property (nonatomic, strong)UIImageView* btn_add;
@end

@implementation PublishAlbumTopView
@synthesize dataList = _dataList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BGViewColor;
        _btn_add = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_publish"]];
        _btn_add.userInteractionEnabled = YES;
        _btn_add.frame = CGRectMake(20, 20, PublishImageTileWidth, PublishImageTileHeight);
        [self addSubview:_btn_add];
        UITapGestureRecognizer* _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_btn_add addGestureRecognizer:_tap];
    }
    return self;
}

- (void)tapAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showPickImgs:)]) {
        [self.delegate showPickImgs:self.dataList];
    }
}

- (void)addImgUrls:(NSArray*)array
{
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:array];
    [self initView];
}

- (void)initView
{

    NSArray *subViews = self.subviews;
    for (UIView *v in subViews) {
        
        [v removeFromSuperview];
    }

    float width = 20.0f;
    float height = 20.0f;
    for (NSInteger i = 0; i < _dataList.count; i++) {
        
        if ((width + PublishImageTileWidth) > Screen_Width) {
            height += PublishImageTileHeight + 20;
            width = 20.0f;
        }
        
        AlbumImageTileView* albumImageTileView = [[AlbumImageTileView alloc] initWithFrame:CGRectMake(width, height, PublishImageTileWidth, PublishImageTileHeight)];
        albumImageTileView.delegate = self;
        ALAsset* asset = (ALAsset*)[_dataList objectAtIndex:i];
        [albumImageTileView setViewData:asset];
        [self addSubview:albumImageTileView];
        
         width += PublishImageTileWidth + 20;
    }
    
    if (self.dataList.count < _imageMaxCount || self.dataList.count == 0) {
        
        if ((width + PublishImageTileWidth) > Screen_Width) {
            height += PublishImageTileHeight + 20;
            width = 20.0f;
        }
        _btn_add.frame = CGRectMake(width, height, _btn_add.frame.size.width, _btn_add.frame.size.height);
        [self addSubview:_btn_add];
    }
    
    CGRect frame = self.frame;
    frame.size.height = height + PublishImageTileHeight + 20;
    self.frame = frame;
    
    if ([_delegate respondsToSelector:@selector(updateFrame:)]) {
        
        [_delegate updateFrame:frame.size.height];
    }
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataList;
}

#pragma mark -
#pragma mark AlbumImageTileViewDelegate
- (void)removeImage:(ALAsset*)asset
{
    [self.dataList removeObject:asset];
    [self initView];
}

@end
