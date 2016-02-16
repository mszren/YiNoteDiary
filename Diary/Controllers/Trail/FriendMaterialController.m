//
//  FriendMaterialController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "FriendMaterialController.h"
#import "BaseNavigation.h"
#import "CheckoutMessageView.h"
#import "SPKitExample.h"
#import "MWPhotoBrowser.h"
#import "LocationManager.h"

@interface FriendMaterialController () <CheckoutMessageViewDelegate,MWPhotoBrowserDelegate>
@property(nonatomic, strong) NSMutableArray *dataList;

@end

@implementation FriendMaterialController{
    
    UIBarButtonItem* _rightButton;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
   
}

- (void)initView{
    
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_more@3x"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.messageBtn.frame.size.height + self.messageBtn.frame.origin.y + 10);
    _faceImg.userInteractionEnabled = YES;
    [_faceImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    [_otherQueueView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
    
    [_addFriendBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_messageBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _dataList = [[TravelDataManage shareInstance] loadTravelListData];
}

#pragma mark -- CheckoutMessageViewDelegate
- (void)CheckoutMessageView:(NSString *)message{
    
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  1;
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
   
    MWPhoto *mwPhoto = [[MWPhoto alloc] initWithImage:self.faceImg.image];
    
    return mwPhoto;
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
    NSDictionary *dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_CHAT_SET withContext:dic];
}

- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
        {
           [[CheckoutMessageView sharedInstance] showCheckoutMessageView:@"验证信息" andRemind:@"请输入验证信息" andDelegate:self];
        }
            break;
            
        default:{
            YWPerson *person = [[YWPerson alloc] initWithPersonId:@"uid1"];
            [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
 
        }
            break;
    }
}

#pragma mark -- UITapGestureRecognizer Action
- (void)onTap:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
            
        case 104:{
            [[TravelDataManage shareInstance] updateAllTravelFinish];
            
            TravelEntity * aModel = [[TravelEntity alloc] initWithName:@"北京" logo:@"北京" travelDesc:@"北京__故宫"];
            aModel.createTime = [NSDate currentTime];
            aModel.startLatitude = [LocationManager shareInstance].currentCoord.latitude;
            aModel.startLongitude = [LocationManager shareInstance].currentCoord.longitude;
            
            if ([[TravelDataManage shareInstance] insertTravelEnity:aModel]) {
                TravelEntity * temp = [[TravelDataManage shareInstance] selectTravelEntityByuuid:aModel.uuid];
                NSDictionary *dic = @{ACTION_Controller_Name : self,ACTION_Controller_Data : @{CurrentTravelEntity : temp, IsShowMember : @YES }};
                [self RouteMessage:ACTION_SHOW_MYTRAIL withContext:dic];
                
            }
        }
            
            break;
            
        case 300:{
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            [browser setCurrentPhotoIndex:1];
            [self.navigationController pushViewController:browser animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"详细资料"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE
@end
