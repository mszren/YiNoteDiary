//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "MessageFrame.h"
#import "EGOImageView.h"
#import "MWPhotoBrowser.h"
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ToastManager.h"
#import <MapKit/MapKit.h>
#import "LocationView.h"

@interface MessageCell () <MWPhotoBrowserDelegate,AVAudioPlayerDelegate,MKMapViewDelegate>
{
    UIButton     *_timeBtn; //时间按钮
    UIImageView *_iconView; //头像按钮
    UIButton    *_contentBtn; //内容按钮
    EGOImageView *_stuffImg; //内容图片
    UILabel *_stuffTimeLabel; //录音计时
    UIButton *_errorBtn; //警告按钮
    Message *_message;
    NSMutableArray *_photos;
    AVAudioPlayer *_avPlayer;
    MKMapView *_mapView; //分享的地图
}

@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.cornerRadius = 20;
        _iconView.clipsToBounds = YES;
        _iconView.layer.shouldRasterize = YES;
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        [_contentBtn addTarget:self action:@selector(onContentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_contentBtn];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        longPress.minimumPressDuration = 0.5; //定义按的时间
        [_contentBtn addGestureRecognizer:longPress];
        
        //4、非文本文件时创建发送实体图片
        _stuffImg = [[EGOImageView alloc]init];
        _stuffImg.userInteractionEnabled = NO;
        [_contentBtn addSubview:_stuffImg];
        
        //5、录音时长label
        _stuffTimeLabel = [[UILabel alloc]init];
        _stuffTimeLabel.font = FONT_SIZE_16;
        _stuffTimeLabel.textColor = COLOR_GRAY_DEFAULT_153;
        [self.contentView addSubview:_stuffTimeLabel];
        [_stuffTimeLabel setHidden:YES];
        
        //6、警告按钮
        _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_errorBtn setImage:[UIImage imageNamed:@"messageSendFail"] forState:UIControlStateNormal];
        [self.contentView addSubview:_errorBtn];
        [_errorBtn setHidden:YES];
        
        //7、位置地图
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.mapType = MKMapTypeStandard;
        _mapView.zoomEnabled = YES;
        [_stuffImg addSubview:_mapView];
        [_mapView setHidden:YES];
        
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    _message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:_message.time forState:UIControlStateNormal];

    _timeBtn.frame = _messageFrame.timeF;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:_message.icon];
    _iconView.frame = _messageFrame.iconF;
    
    // 3、设置内容
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    if (_message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
   //4、设置点击状态
    UIImage *normal , *focused;
    if (_message.type == MessageTypeMe) {
    
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
    
    //、设置警告按钮
    _errorBtn.frame = _messageFrame.errorF;
    [_errorBtn setHidden:YES];
    
    //6、设置按钮内容（文字、图片、语音或音频)
    switch (_message.contentType) {
        case MessageContentFile:{
            _stuffImg.image = nil;
            [_mapView setHidden:YES];
            [_stuffTimeLabel setHidden:YES];
            [_contentBtn setTitle:_message.content forState:UIControlStateNormal];
        }
            break;
        case MessageContentVoice:{
            [_mapView setHidden:YES];
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            CGRect voiceRect = _messageFrame.stuffF;
            voiceRect.size.width = 20;
            _stuffImg.frame = voiceRect;
            _stuffImg.image = [UIImage imageNamed:@"btn_kanzhe_tbyy_selected"];
            
            _stuffTimeLabel.frame = _messageFrame.StuffTimeF;
            _stuffTimeLabel.text = [NSString stringWithFormat:@"%ld''",(long)_message.contentTime];
            [_stuffTimeLabel setHidden:NO];
        }
            
            break;
        case MessageContentPicture:{
            [_stuffTimeLabel setHidden:YES];
            [_mapView setHidden:YES];
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.layer.cornerRadius = 8;
            _stuffImg.clipsToBounds = YES;
            _stuffImg.layer.shouldRasterize = YES;
            _stuffImg.frame = _messageFrame.stuffF;
            _stuffImg.image = _message.contentImg;
        }
            break;
        case MessageContentLocation:{
            
            [_stuffTimeLabel setHidden:YES];
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.frame = _messageFrame.stuffF;
            CGRect imgRect = _messageFrame.stuffF;
            _mapView.frame = CGRectMake(0, 0, imgRect.size.width, imgRect.size.height);
            [_mapView setHidden:NO];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_message.locationDic[@"latitude"] floatValue], [_message.locationDic[@"longitude"] floatValue]);
            MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
            
            MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
            [_mapView setRegion:region];//指定地图的显示范围。
            MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
            pin.coordinate = coordinate;
            pin.title = _message.locationDic[@"address"];
            [_mapView addAnnotation:pin];
        }
            
            break;
        case MessageContentAudio:{
            [_stuffTimeLabel setHidden:YES];
            [_mapView setHidden:YES];
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.frame = _messageFrame.stuffF;
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- UILongPressGestureRecognizer
- (void)onLongPress:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        //复制
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        
        //收藏
        UIMenuItem *collectItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collectItemClicked:)];
        
        //分享
        UIMenuItem *shareItem = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(shareItemClicked:)];
        
        switch (_message.contentType) {
            case MessageContentFile:{
                
                UIMenuController *fileMenu = [UIMenuController sharedMenuController];
                fileMenu.menuItems = @[copyItem,collectItem,shareItem];
                [fileMenu setMenuVisible:YES animated:YES];
                [fileMenu setTargetRect:_messageFrame.contentF inView:self];
            }
                break;
                
            case MessageContentPicture:{
                
                UIMenuController *pictureMenu = [UIMenuController sharedMenuController];
                pictureMenu.menuItems = @[collectItem,shareItem];
                [pictureMenu setMenuVisible:YES animated:YES];
                [pictureMenu setTargetRect:_messageFrame.contentF inView:self];
            }
                
                break;
                
            case MessageContentVoice:
                
                break;
                
            case MessageContentAudio:
                
                break;
                
            default:
                break;
        }
    }
}


//处理item点击事件
- (void)copyItemClicked:(UIMenuItem *)item
{
    NSLog(@"复制");
}

- (void)collectItemClicked:(UIMenuItem *)item
{
    NSLog(@"收藏");
}

- (void)shareItemClicked:(UIMenuItem *)item
{
    NSLog(@"分享");
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copyItemClicked:)) {
        
        return YES;
    }else if(action == @selector(collectItemClicked:))
    {
        return YES;
    }else if (action == @selector(shareItemClicked:)){
        
        return YES;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark -- UIButton Action
- (void)onContentBtn:(UIButton *)sender{
    
    switch (_message.contentType) {
        case MessageContentFile:
            
            break;
        case MessageContentVoice:{
            
            [self openRecord];
        }
            
            break;
        case MessageContentPicture:{
            
            [self openPhotoBrower:_message.contentImg];
        }
            
            break;
        case MessageContentAudio:
            
            break;
        case MessageContentLocation:{
            
            [[LocationView sharedInstance] showLocationView:_message.locationDic];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//打开MWPhotoBrowser
- (void)openPhotoBrower:(id)sendContent{
    
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = YES;
    BOOL autoPlayOnAppear = NO;
    MWPhoto *photo = [MWPhoto photoWithImage:sendContent];
    _photos = [[NSMutableArray alloc]initWithCapacity:0];
    [_photos addObject:photo];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    [self.viewController.navigationController pushViewController:browser animated:YES];
}

//播放录音
- (void)openRecord{
    NSLog(@"url :%@",_message.voiceUrl);
    NSError *error;
    _avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_message.voiceUrl error:&error];
    if (error) {
        
        [ToastManager showToast:error.localizedDescription withTime:2];
    }
    _avPlayer.delegate = self;
    [_avPlayer prepareToPlay];
    [_avPlayer play];
}

#pragma mark -- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [_avPlayer stop];
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

@end
