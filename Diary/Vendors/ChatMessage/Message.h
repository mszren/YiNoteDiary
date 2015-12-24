//
//  Message.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    MessageTypeMe = 0, // 自己发的
    MessageTypeOther = 1 //别人发得
    
} MessageType;

typedef enum {
    MessageContentFile = 0, //文本文件
    MessageContentVoice = 1, //录音文件
    MessageContentPicture = 2, //图片文件
    MessageContentAudio = 3, //音频文件
    MessageContentLocation = 4, //位置
    MessageContentRed = 5, //红包
    
}MessageContentType;


@interface Message : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger contentTime;
@property (nonatomic, copy) UIImage *contentImg;
@property (nonatomic, copy) NSDictionary *locationDic;
@property (nonatomic, copy) NSURL *voiceUrl;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageContentType contentType;

@property (nonatomic, copy) NSDictionary *dict;

@end
