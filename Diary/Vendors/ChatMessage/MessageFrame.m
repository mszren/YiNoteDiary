//
//  MessageFrame.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//



#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    if (_showTime){
        
        CGFloat timeY = kMargin;
        CGSize timeSize = [_message.time sizeWithAttributes:@{UIFontDescriptorSizeAttribute: @"16"}];
//        CGSize timeSize = [_message.time sizeWithFont:kTimeFont];
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);
    }
    // 2、计算头像位置
    CGFloat iconX = kMargin;
    // 2.1 如果是自己发得，头像在右边
    if (_message.type == MessageTypeMe) {
        iconX = screenW - kMargin - kIconWH;
    }

    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    // 3、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGFloat stuffX =  10;
    CGFloat stuffY =  4;
    CGFloat stuffTimeX = contentX;
    CGFloat stuffTimeY = iconY + 6 ;
    CGFloat errorX;
    CGFloat errorY = iconY + 6;
    
    CGSize contentSize;
    CGSize stuffSize;
    CGSize stuffTimeSize;
    CGSize errorSize;
    switch (_message.contentType) {
        case  MessageContentFile:{
            
            static float systemVersion;
            static dispatch_once_t onceToken;
            
            dispatch_once(&onceToken, ^{
                systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
            });
            if (systemVersion >= 7.0) {
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle setLineSpacing:0];
                contentSize = [_message.content boundingRectWithSize:CGSizeMake(kContentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                                   NSFontAttributeName:kContentFont,
                                                                                                                                                                   NSParagraphStyleAttributeName:paragraphStyle
                                                                                                                                                                   } context:nil].size;
            }else{
                
                            contentSize = [_message.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentW, CGFLOAT_MAX)];
            }
            

        }
            
            break;
        case  MessageContentVoice:{
            
            contentSize = CGSizeMake(KcontentVoiceW, KcontentVoiceH);
            stuffTimeSize = CGSizeMake(KcontentVoiceTimeW, KcontentVoiceTimeH);
            stuffTimeX = contentX + contentSize.width + 10;
            errorX = stuffTimeX + 30;
        }
            
            break;
        case  MessageContentPicture:{
            
            contentSize = CGSizeMake(KcontentPictureWH, KcontentPictureWH);
        }
            
            break;
        case MessageContentLocation:{
            
            contentSize = CGSizeMake(KcontentPictureWH, KcontentPictureWH);
        }
            
            break;
        case  MessageContentAudio:{
            
            contentSize = CGSizeMake(KcontentPictureWH, KcontentPictureWH);
        }
            break;
            
        default:
            break;
    }
    
    stuffSize = CGSizeMake(contentSize.width, contentSize.height);
    errorSize = CGSizeMake(KErrorBtnWH, KErrorBtnWH);
    errorX = contentX + contentSize.width + kContentLeft + kContentRight + 10;
    
    if (_message.type == MessageTypeMe) {
        contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
        errorX = contentX - 30;
    }
    
    if (_message.type == MessageTypeMe && _message.contentType == MessageContentVoice) {
        
        stuffY = 6;
        stuffX = stuffSize.width;
        stuffTimeX = contentX - 20;
        errorX = stuffTimeX - 30;
    }
    
    _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
    
    _stuffF = CGRectMake(stuffX, stuffY, stuffSize.width + 10, stuffSize.height + 13);
    
    _StuffTimeF = CGRectMake(stuffTimeX, stuffTimeY, stuffTimeSize.width, stuffTimeSize.height);
    
    _errorF = CGRectMake(errorX, errorY, errorSize.width, errorSize.height);
    
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end
