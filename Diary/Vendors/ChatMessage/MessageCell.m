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

@interface MessageCell () <MWPhotoBrowserDelegate>
{
    UIButton     *_timeBtn;
    UIImageView *_iconView;
    UIButton    *_contentBtn;
    EGOImageView *_stuffImg;
    Message *_message;
    NSMutableArray *_photos;
}

@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#warning 必须先设置为clearColor，否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        [_contentBtn addTarget:self action:@selector(onContentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_contentBtn];
        
        //4、非文本文件时创建发送实体图片
        _stuffImg = [[EGOImageView alloc]init];
        _stuffImg.userInteractionEnabled = NO;
        [_contentBtn addSubview:_stuffImg];
        
    }
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
    
    //5、设置按钮内容（文字、图片、语音或音频)
    switch (_message.contentType) {
        case MessageContentFile:{
            _stuffImg.image = nil;
            [_contentBtn setTitle:_message.content forState:UIControlStateNormal];
        }
            break;
        case MessageContentVoice:{
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.frame = _messageFrame.stuffF;
            _stuffImg.image = [UIImage imageNamed:@"btn_kanzhe_tbyy_selected"];
        }
            
            break;
        case MessageContentPicture:{
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.layer.cornerRadius = 8;
            _stuffImg.clipsToBounds = YES;
            _stuffImg.layer.shouldRasterize = YES;
            _stuffImg.frame = _messageFrame.stuffF;
            _stuffImg.image = _message.contentImg;
        }
            
            break;
        case MessageContentAudio:{
            
            [_contentBtn setTitle:nil forState:UIControlStateNormal];
            _stuffImg.frame = _messageFrame.stuffF;
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- UIButton Action
- (void)onContentBtn:(UIButton *)sender{
    
    switch (_message.contentType) {
        case MessageContentFile:
            
            break;
        case MessageContentVoice:
            
            break;
        case MessageContentPicture:{
            
            BOOL displayActionButton = YES;
            BOOL displaySelectionButtons = NO;
            BOOL displayNavArrows = NO;
            BOOL enableGrid = YES;
            BOOL startOnGrid = YES;
            BOOL autoPlayOnAppear = NO;
            MWPhoto *photo = [MWPhoto photoWithImage:_message.contentImg];
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
            
            break;
        case MessageContentAudio:
            
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

@end
