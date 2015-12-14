//
//  InviteController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "InviteController.h"
#import "BaseNavigation.h"

@interface InviteController ()

@end

@implementation InviteController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BaseNavigation setGreenNavigationBar:self andTitle:@"分享"];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.weichatKoneView.frame.size.height + self.weichatKoneView.frame.origin.y + 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
