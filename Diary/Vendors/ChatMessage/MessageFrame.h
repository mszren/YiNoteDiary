//
//  MessageFrame.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度
#define KcontentPictureWH 120 //内容图片(音频)宽高
#define KcontentVoiceH 10//内容录音高
#define KcontentVoiceW 40//内容录音宽
#define KcontentVoiceTimeW 20 //录音时间label宽
#define KcontentVoiceTimeH 20 //录音时间label高
#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define kContentTop 15 //文本内容与按钮上边缘间隔
#define kContentLeft 25 //文本内容与按钮左边缘间隔
#define kContentBottom 15 //文本内容与按钮下边缘间隔
#define kContentRight 15 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Message;

@interface MessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;
@property (nonatomic, assign, readonly) CGRect stuffF; //内容填充（图片或音频)
@property (nonatomic, assign, readonly) CGRect StuffTimeF; //录音时间长

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell高度

@property (nonatomic, strong) Message *message;


@property (nonatomic, assign) BOOL showTime;

@end
