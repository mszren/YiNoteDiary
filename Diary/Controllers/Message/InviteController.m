//
//  InviteController.m
//  Diary
//
//  Created by 我 on 15/11/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "InviteController.h"
#import "BaseNavigation.h"
#import "UMSocial.h"

@interface InviteController () <UMSocialUIDelegate, UMSocialDataDelegate>

@end

@implementation InviteController
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.weichatKoneView.frame.size.height + self.weichatKoneView.frame.origin.y + 10);
    
    UITapGestureRecognizer *qqTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShareTap:)];
    [self.qqView addGestureRecognizer:qqTap];
    
    UITapGestureRecognizer *weichatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShareTap:)];
    [self.weichatView addGestureRecognizer:weichatTap];
    
    UITapGestureRecognizer *weiboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShareTap:)];
    [self.weiboView addGestureRecognizer:weiboTap];
    
    UITapGestureRecognizer *qqKoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShareTap:)];
    [self.qqKoneView addGestureRecognizer:qqKoneTap];
    
    UITapGestureRecognizer *weichatKoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onShareTap:)];
    [self.weichatKoneView addGestureRecognizer:weichatKoneTap];
}

#pragma mark -- UITapGestureRecognizer
- (void)onShareTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
            
            
        case 100:{
            
            //QQ邀请
            
            [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:[UIImage imageNamed:@"pic_bg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            

        }
            
            break;
            
        case 101:{
            
            //微信邀请
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatSession ]
                                                               content:@"测试一下"
                                                                 image:[UIImage imageNamed:@"pic_bg"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {
                                                                
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];


        }
            
            break;
            
        case 102:{
            
            //微博邀请
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:[UIImage imageNamed:@"pic_bg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            
            break;
            
        case 103:{
            
            //QQ空间邀请
            //Qzone分享文字与图片缺一不可，否则会出现错误码10001
            
            [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
            [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享文字" image:[UIImage imageNamed:@"pic_bg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            
            break;
            
        default:{
            
            //微信朋友圈
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"家家帮里赚翻天！帮币冲抵更省钱";
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[ UMShareToWechatTimeline ]
                                                               content:@"家家帮里赚翻天！帮币冲抵更省钱"
                                                                 image:[UIImage imageNamed:@"108x108"]
                                                              location:nil
                                                           urlResource:nil
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity* response) {
                                                                
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    NSLog(@"分享成功！");
                                                                }
                                                            }];
        }
            break;
    }
}

#pragma mark-- UM
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity*)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if (response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@", [[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"分享"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE
 
@end
