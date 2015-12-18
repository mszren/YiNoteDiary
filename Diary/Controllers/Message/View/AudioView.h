//
//  publishVIew.h
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>

@protocol AudioViewDelegate <NSObject>

-(void)AudioViewDelegateWithAudioFile:(NSURL *)fileUrl;;

@end

@interface AudioView : NSObject <AVAudioRecorderDelegate>
@property (nonatomic,weak) id <AudioViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)NSString *tag;
@property (nonatomic,strong)UIButton *recordBtn;
@property (nonatomic,strong)UIButton *luzhiBtn;
@property (nonatomic,strong)UIButton *bofanBtn;
@property (nonatomic,strong)UILabel *luzhiLabel;

+ (instancetype)sharedInstance;

-(void)showAudioView:(id<AudioViewDelegate>)delegate;

@end
