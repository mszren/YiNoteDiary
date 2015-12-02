//
//  IdentifyEditView.h
//  Diary
//
//  Created by 我 on 15/11/18.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaiDodgeKeyboard.h"

@protocol IdentifyEditViewDelegate <NSObject>

- (void)identifyEditView:(NSString *)address;

@end

@interface IdentifyEditView : NSObject
@property (nonatomic,weak)id<IdentifyEditViewDelegate>delegate;
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIViewController * viewController;
@property (nonatomic,strong)UIView * backGroundView;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *certainBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *contentView;
@property (nonatomic,strong)NSString *address;

+ (instancetype)sharedInstance;

- (void)showIdentifyEditView:(NSString *)context andDelegate:(id<IdentifyEditViewDelegate>)delegate;

@end
