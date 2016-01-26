//
//  RecordView.h
//  Diary
//
//  Created by 我 on 16/1/4.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"

@protocol RecordViewDelegate <NSObject>

- (void)recordViewDelegateFinishTrail;

@end

@interface RecordView : UIView <DBCameraViewControllerDelegate>
@property (nonatomic, weak)id<RecordViewDelegate>delegate;
@property (nonatomic, strong)UIViewController *viewController;
@property (nonatomic, strong)UIButton *memberBtn;
@property (nonatomic, strong)UIButton *cameraBtn;
@property (nonatomic, strong)UIButton *finishBtn;
@property (nonatomic, strong)UILabel *grayLabel;

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id<RecordViewDelegate>)delegate;

@end
