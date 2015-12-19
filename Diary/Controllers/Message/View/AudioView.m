//
//  publishVIew.m
//  gaode
//
//  Created by 我 on 15/10/14.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "AudioView.h"

#define WIDTH (Screen_Width - 240)/4
@implementation AudioView  
{
    
    NSTimer *_timer;
    UILabel * _timeLabel;
    NSInteger _timeTick;//录制时间
    NSInteger _recordTime;//播放时间
    NSURL *_recordedTmpFile;
    LVRecordTool *_recordTool;
}

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showAudioView:(id<AudioViewDelegate>)delegate{
    
    self.delegate = delegate;

    _timeTick = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    _viewController = [[UIViewController alloc]init];
    self.window.rootViewController = _viewController;
    
    UIButton *styleView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - 200)];
    styleView.tag = 100;
    [_viewController.view addSubview:styleView];
    [styleView addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height - 200, Screen_Width, 200)];
    _backGroundView.alpha = 1;
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [_viewController.view addSubview:_backGroundView];
    
    UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
    greenLabel.backgroundColor = BGViewGreen;
    [_backGroundView addSubview:greenLabel];
  
    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordBtn.frame = CGRectMake(Screen_Width - 70, 10, 60, 30);
    [_recordBtn setTitle:@"重录" forState:UIControlStateNormal];
    _recordBtn.layer.cornerRadius = 4;
    _recordBtn.clipsToBounds = YES;
    _recordBtn.tag = 200;
    _recordBtn.hidden = YES;
    _recordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_recordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_recordBtn setBackgroundColor:BGViewGreen];
    _recordBtn.adjustsImageWhenDisabled = NO;
    [_backGroundView addSubview:_recordBtn];
    [_recordBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, Screen_Width, 20)];
    _timeLabel.text = @"00:00";
    _timeLabel.textColor = BGViewGreen;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:25];
    [_backGroundView addSubview:_timeLabel];
    
    NSArray *btnTitles = @[@"btn_kanzhe_tbyy_selected",@"btn_kanzhe_yuying",@"bg_kanzhe_fsp",@"btn_kanzhe_fyy"];
    
    _luzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _luzhiBtn.frame = CGRectMake((Screen_Width - 70)/2, 65, 70, 70);
    _luzhiBtn.adjustsImageWhenHighlighted = NO;
    _luzhiBtn.tag = 300;
    _luzhiBtn.layer.cornerRadius = 35;
    _luzhiBtn.clipsToBounds = YES;

    [_luzhiBtn setBackgroundImage:[UIImage imageNamed:btnTitles[0]] forState:UIControlStateNormal];
    [_luzhiBtn setBackgroundImage:[UIImage imageNamed:btnTitles[1]] forState:UIControlStateSelected];

    [_luzhiBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:_luzhiBtn];
    
    _bofanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bofanBtn.frame = CGRectMake((Screen_Width - 70)/2, 65, 70, 70);
    _bofanBtn.adjustsImageWhenHighlighted = NO;
    _bofanBtn.tag = 301;
    _bofanBtn.layer.cornerRadius = 35;
    _bofanBtn.clipsToBounds = YES;
    _bofanBtn.hidden = YES;
    [_bofanBtn setBackgroundImage:[UIImage imageNamed:btnTitles[2]] forState:UIControlStateNormal];
    [_bofanBtn setBackgroundImage:[UIImage imageNamed:btnTitles[3]] forState:UIControlStateSelected];
    
    [_bofanBtn addTarget:self action:@selector(onPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:_bofanBtn];
    
    _luzhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, Screen_Width, 13)];
    _luzhiLabel.font = [UIFont systemFontOfSize:13];
    _luzhiLabel.textAlignment = NSTextAlignmentCenter;
    _luzhiLabel.text = @"点击开始录音";
    [_backGroundView addSubview:_luzhiLabel];
    
    //初始化录音设备
    _recordTool = [LVRecordTool sharedRecordTool];
    
    // The window has to be un-hidden on the main thread
   dispatch_async(dispatch_get_main_queue(), ^{
       
       [self.window makeKeyAndVisible];
       
       _backGroundView.alpha = 0;
       _backGroundView.layer.shouldRasterize = YES;
       _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
       [UIView animateWithDuration:0.2 animations:^{
           
           _backGroundView.alpha = 1;
           _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
           
       } completion:^(BOOL finished) {
           
           [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
               _backGroundView.alpha = 1;
               _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
           } completion:^(BOOL finished2) {
               _backGroundView.layer.shouldRasterize = NO;
 
           }];
           
           
         
       }];
       
   });
                   
}

#pragma mark
#pragma mark -- UIButton Action
-(void)onPublishBtn:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 100:{//点击取消录制视图
            [_timer invalidate];
            if ([_recordTool.recorder isRecording]) [_recordTool stopRecording];
            
            if ([_recordTool.player isPlaying]) [_recordTool stopPlaying];
            [self clean];
        }
            break;
            
        case 200:{//重录按钮
            _recordBtn.hidden = YES;
            _luzhiBtn.hidden = NO;
            _bofanBtn.hidden = YES;
            _luzhiLabel.text = @"点击开始录音";
            _timeTick = 0;
            _timeLabel.text = @"00:00";
            [_timer invalidate];
            _timer = nil;
            
            [_recordTool destructionRecordingFile];
            
        }
            
            break;
        case 300:{//录音按钮
            
            UIButton * button = (UIButton *)[_backGroundView viewWithTag:sender.tag];
            button.selected = !button.selected;
            if (button.selected == YES) {
                
                _luzhiLabel.text = @"正在录音中...";
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                [_timer fire];
                [_recordTool startRecording];
                
            }else{
                
                button.hidden = YES;
                _bofanBtn.hidden = NO;
                _bofanBtn.selected = NO;
                _recordBtn.hidden = NO;
                [_timer invalidate];
                _timer = nil;
                _luzhiLabel.text = @"点击播放录音";
                [_recordTool stopRecording];
            }
        }
            
            break;
        case 301:{//播放按钮
            
            UIButton *button = (UIButton *)[_backGroundView viewWithTag:sender.tag];
            button.selected = !button.selected;
            if (button.selected == YES) {
                
                _luzhiLabel.text = @"正在播放录音";
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                [_timer fire];
                [_recordTool playRecordingFile];
            }else{
                
                _luzhiLabel.text = @"点击播放录音";
                _recordTime = 0;
                [_timer invalidate];
                _timer = nil;
                [_recordTool stopPlaying];
            }
        }
            
            break;

        default:
            break;
    }
}

//计时器计时
-(void)timeFireMethod{
    
    if (_luzhiBtn.hidden == NO) {
        
        _timeTick ++;
        NSInteger seconds = _timeTick % 60;
        NSInteger minutes = (_timeTick /60) % 60;
        
        _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)minutes,(long)seconds];
    }else if (_bofanBtn.hidden == NO){
        
        
        if (_recordTime == _timeTick) {
            [_timer invalidate];
            _timer = nil;
            _recordTime = 0;
            _timeLabel.text = @"00:00";
            _bofanBtn.selected = NO;
            _luzhiLabel.text = @"点击播放录音";

        }else{
            _recordTime ++;
            NSInteger seconds = _recordTime % 60;
            NSInteger minutes = (_recordTime /60) % 60;
            
            _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)minutes,(long)seconds];
        }
    }
}

-(void)clean{
    
    // 1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:LVRecordFielName];
    _recordedTmpFile = [NSURL fileURLWithPath:filePath];
    [self.delegate AudioViewDelegateWithAudioFile:_recordedTmpFile];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _backGroundView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            
            _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                _backGroundView.alpha = 0;
                _backGroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2) {
                
                [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
                [self.window removeFromSuperview];
                [self.backGroundView removeFromSuperview];
                self.viewController = nil;
                self.window = nil;
                
                
            }];
            
        }];
        
    });
}

@end
