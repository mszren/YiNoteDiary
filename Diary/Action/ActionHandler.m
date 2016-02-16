//
//  ActionHandler.m
//  Diary
//
//  Created by 我 on 16/2/14.
//  Copyright © 2016年 Owen. All rights reserved.
//

#import "ActionHandler.h"
#import "indexRecentDetailController.h"
#import "PublishController.h"
#import "SelectAdressController.h"
#import "NearPersonController.h"
#import "NearFeatureController.h"
#import "NearPictureController.h"
#import "FriendListController.h"
#import "FriendMaterialController.h"
#import "PersonChatSetController.h"
#import "MyTrailController.h"
#import "FeatureListController.h"
#import "FeatureDetailController.h"
#import "IdentifyController.h"
#import "IdentifyDetailController.h"
#import "MyTeamController.h"
#import "OtherTrailController.h"
#import "TrailSetController.h"
#import "MyAlbumController.h"
#import "PictureSaveController.h"
#import "MyDiaryController.h"
#import "EditDiaryController.h"
#import "NotifationController.h"
#import "AdressBookController.h"
#import "AddFriendController.h"
#import "ScanController.h"
#import "InviteController.h"
#import "SetController.h"
#import "PersonCenterController.h"
#import "SafeController.h"
#import "SecretController.h"
#import "RemindSetController.h"
#import "ChatSetController.h"
#import "LocationBlackController.h"
#import "InforController.h"
#import "EditController.h"
#import "SignController.h"
#import "SexSelectController.h"
#import "AgeController.h"
#import "ProvinceController.h"
#import "CodeController.h"
#import "CityController.h"
#import "RegisterFirstController.h"
#import "RegisterSecondController.h"
#import "RegisterThirdController.h"
#import "RevordPasswordController.h"
#import "RevordPasswordSecondController.h"

@implementation ActionHandler
#pragma mark -
- (NSDictionary*)actionDictionary
{
    if (_mergedDictionary == nil) {
        
        NSDictionary* dic = @{ACTION_SHOW_INDEXDETAIL : [self wrapSelector:@selector(showIndexDetail:)],
                              ACTION_SHOW_PUBLISH : [self wrapSelector:@selector(showPublish:)],
                              ACTION_SHOW_PUBLISH_SELECTADRESS : [self wrapSelector:@selector(showPublishAdress:)],
                              ACTION_SHOW_NEAR_PERSON : [self wrapSelector:@selector(showNearPerson:)],
                              ACTION_SHOW_NEAR_FEARTURE : [self wrapSelector:@selector(showNearFearture:)],
                              ACTION_SHOW_NEAR_PHOTO : [self wrapSelector:@selector(showNearPhoto:)],
                              ACTION_SHOW_NEAR_PERSONLIST : [self wrapSelector:@selector(showNearPersonList:)],
                              ACTION_SHOW_NEAR_PERSONMATERIAL : [self wrapSelector:@selector(showNearPersonMaterial:)],
                              ACTION_SHOW_CHAT_SET : [self wrapSelector:@selector(showChatSet:)],
                              ACTION_SHOW_MYTRAIL : [self wrapSelector:@selector(showMytrail:)],
                              ACTION_SHOW_NEAR_FEARTURE_LIST : [self wrapSelector:@selector(showFeatureList:)],
                              ACTION_SHOW_NEAR_FEARTURE_DETAIL : [self wrapSelector:@selector(showFeatureDetail:)],
                              ACTION_SHOW_IDENTIFY : [self wrapSelector:@selector(showIdentify:)],
                              ACTION_SHOW_IDENTIFY_DETAIL : [self wrapSelector:@selector(showIdentifyDetail:)],
                              ACTION_SHOW_MYTEAM : [self wrapSelector:@selector(showMyTeam:)],
                              ACTION_SHOW_OTHERTRAIL : [self wrapSelector:@selector(showOtherTrail:)],
                              ACTION_SHOW_TRAILSET : [self wrapSelector:@selector(showTrailSet:)],
                              ACTION_SHOW_MYALBUM : [self wrapSelector:@selector(showMyAlbum:)],
                              ACTION_SHOW_PICTURESAVE : [self wrapSelector:@selector(showPictureSave:)],
                              ACTION_SHOW_MYDIARY : [self wrapSelector:@selector(showMyDiary:)],
                              ACTION_SHOW_EDITDIARY : [self wrapSelector:@selector(showEditDiary:)],
                              ACTION_SHOW_NOTIFATION : [self wrapSelector:@selector(showNotifation:)],
                              ACTION_SHOW_ADRESSBOOK : [self wrapSelector:@selector(showAdressBook:)],
                              ACTION_SHOW_ADDFRIEND : [self wrapSelector:@selector(showAddFriend:)],
                              ACTION_SHOW_LOCATIONBLACK : [self wrapSelector:@selector(showLocationBlack:)],
                              ACTION_SHOW_SCAN : [self wrapSelector:@selector(showScan:)],
                              ACTION_SHOW_INVITE : [self wrapSelector:@selector(showInvite:)],
                              ACTION_SHOW_MY_SET : [self wrapSelector:@selector(showMySet:)],
                              ACTION_SHOW_MY_PERSONCENTER : [self wrapSelector:@selector(showPersonCenter:)],
                              ACTION_SHOW_MY_SECRET : [self wrapSelector:@selector(showMySecert:)],
                              ACTION_SHOW_MY_SAFE : [self wrapSelector:@selector(showMySafe:)],
                              ACTION_SHOW_MY_REMIND : [self wrapSelector:@selector(showMyRemind:)],
                              ACTION_SHOW_MY_CAHTSET : [self wrapSelector:@selector(showMyChatSet:)],
                              ACTION_SHOW_MY_INFO : [self wrapSelector:@selector(showMyInfo:)],
                              ACTION_SHOW_MY_EDIT : [self wrapSelector:@selector(showMyEdit:)],
                              ACTION_SHOW_MY_SIGN : [self wrapSelector:@selector(showMySign:)],
                              ACTION_SHOW_MY_SEX : [self wrapSelector:@selector(showMySex:)],
                              ACTION_SHOW_MY_AGE : [self wrapSelector:@selector(showMyAge:)],
                              ACTION_SHOW_MY_PROVINCE : [self wrapSelector:@selector(showMyProvince:)],
                              ACTION_SHOW_MY_CODE : [self wrapSelector:@selector(showMyCode:)],
                              ACTION_SHOW_MY_CITY : [self wrapSelector:@selector(showMyCity:)],
                              ACTION_SHOW_REGISTER_1 : [self wrapSelector:@selector(showRegisterI:)],
                              ACTION_SHOW_REGISTER_2 : [self wrapSelector:@selector(showRegisterII:)],
                              ACTION_SHOW_REGISTER_3 : [self wrapSelector:@selector(showRegisterIII:)],
                              ACTION_SHOW_REVORED : [self wrapSelector:@selector(showRevoredI:)],
                              ACTION_SHOW_REVORED_2 : [self wrapSelector:@selector(showRevoredII:)]
                               };
        _mergedDictionary = [[NSMutableDictionary alloc] initWithDictionary:[super actionDictionary]];
        [_mergedDictionary addEntriesFromDictionary:dic];
    }
    
    return _mergedDictionary;
}

/**
 *  跳转到首页详情页面
 *
 *  @param context
 */
- (void)showIndexDetail:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    indexRecentDetailController* controller = [[indexRecentDetailController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发布页面
 *
 *  @param context <#context description#>
 */
- (void)showPublish:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSMutableArray* dataDic = [dic objectForKey:ACTION_Controller_Data];
    PublishController* controller = [[PublishController alloc] init];
    controller.messageListner = pushController;
    controller.assets = dataDic;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发布选择地址页面
 *
 *  @param context <#context description#>
 */
- (void)showPublishAdress:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SelectAdressController* controller = [[SelectAdressController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近的人页面
 *
 *  @param context
 */
- (void)showNearPerson:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NearPersonController* controller = [[NearPersonController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近的人列表页面
 *
 *  @param context
 */
- (void)showNearPersonList:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSString* title = [dic objectForKey:ACTION_Controller_Data];
    FriendListController* controller = [[FriendListController alloc] init];
    controller.messageListner = pushController;
    controller.title = title;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近的人资料页面
 *
 *  @param context
 */
- (void)showNearPersonMaterial:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    FriendMaterialController* controller = [[FriendMaterialController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    controller.navigationController.navigationBarHidden = NO;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到聊天设置页面
 *
 *  @param context
 */
- (void)showChatSet:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    PersonChatSetController* controller = [[PersonChatSetController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近景点页面
 *
 *  @param context
 */
- (void)showNearFearture:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NearFeatureController* controller = [[NearFeatureController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近景点列表页面
 *
 *  @param context
 */
- (void)showFeatureList:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    FeatureListController* controller = [[FeatureListController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近景点详情页面
 *
 *  @param context
 */
- (void)showFeatureDetail:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    FeatureDetailController* controller = [[FeatureDetailController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到发现_附近照片页面
 *
 *  @param context
 */
- (void)showNearPhoto:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NearPictureController* controller = [[NearPictureController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我的轨迹页面
 *
 *  @param context
 */
- (void)showMytrail:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSDictionary * dict = [dic objectForKey:ACTION_Controller_Data];
    MyTrailController* controller = [[MyTrailController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    controller.currentTravelEntity = dict[CurrentTravelEntity];
    controller.isShowMember = [dict[IsShowMember] boolValue];
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到拍照识别页面
 *
 *  @param context
 */
- (void)showIdentify:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    UIImage *camerImg = [dic objectForKey:ACTION_Controller_Data];
    IdentifyController* controller = [[IdentifyController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    controller.cameraImg = camerImg;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到拍照识别详情页面
 *
 *  @param context
 */
- (void)showIdentifyDetail:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
     UIImage *camerImg = [dic objectForKey:ACTION_Controller_Data];
    IdentifyDetailController* controller = [[IdentifyDetailController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    controller.featureImg = camerImg;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到TA的轨迹页面
 *
 *  @param context
 */
- (void)showOtherTrail:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSDictionary * dict = [dic objectForKey:ACTION_Controller_Data];
    OtherTrailController* controller = [[OtherTrailController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    controller.currentTravelEntity = dict[CurrentTravelEntity];
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我的队员页面
 *
 *  @param context
 */
- (void)showMyTeam:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    MyTeamController* controller = [[MyTeamController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到轨迹设置页面
 *
 *  @param context
 */
- (void)showTrailSet:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    TrailSetController* controller = [[TrailSetController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到位置黑名单页面
 *
 *  @param context
 */
- (void)showLocationBlack:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    LocationBlackController* controller = [[LocationBlackController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到生成专辑页面
 *
 *  @param context
 */
- (void)showMyAlbum:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    MyAlbumController* controller = [[MyAlbumController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到照片保存页面
 *
 *  @param context
 */
- (void)showPictureSave:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSString *title = [dic objectForKey:ACTION_Controller_Data];
    PictureSaveController* controller = [[PictureSaveController alloc] init];
    controller.messageListner = pushController;
    controller.saveTitleStr = title;
    controller.hidesBottomBarWhenPushed = YES;
    controller.navigationController.navigationBarHidden = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我的日记页面
 *
 *  @param context
 */
- (void)showMyDiary:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    MyDiaryController* controller = [[MyDiaryController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到编辑日记页面
 *
 *  @param context
 */
- (void)showEditDiary:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    EditDiaryController* controller = [[EditDiaryController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到系统通知页面
 *
 *  @param context
 */
- (void)showNotifation:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NotifationController* controller = [[NotifationController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到联系人页面
 *
 *  @param context
 */
- (void)showAdressBook:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    AdressBookController* controller = [[AdressBookController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到添加好友页面
 *
 *  @param context
 */
- (void)showAddFriend:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    AddFriendController* controller = [[AddFriendController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到扫一扫页面
 *
 *  @param context
 */
- (void)showScan:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    ScanController* controller = [[ScanController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到添加好友页面
 *
 *  @param context
 */
- (void)showInvite:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    InviteController* controller = [[InviteController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_设置页面
 *
 *  @param context
 */
- (void)showMySet:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SetController* controller = [[SetController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_个人中心页面
 *
 *  @param context
 */
- (void)showPersonCenter:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    PersonCenterController* controller = [[PersonCenterController alloc] init];
    controller.messageListner = pushController;
    controller.navigationController.navigationBarHidden = NO;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_账户安全页面
 *
 *  @param context
 */
- (void)showMySafe:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SafeController* controller = [[SafeController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_隐私设置页面
 *
 *  @param context
 */
- (void)showMySecert:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SecretController* controller = [[SecretController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_提醒页面
 *
 *  @param context
 */
- (void)showMyRemind:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RemindSetController* controller = [[RemindSetController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_聊天设置页面
 *
 *  @param context
 */
- (void)showMyChatSet:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    ChatSetController* controller = [[ChatSetController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_关于我们页面
 *
 *  @param context
 */
- (void)showMyInfo:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    InfoController* controller = [[InfoController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_昵称修改页面
 *
 *  @param context
 */
- (void)showMyEdit:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    EditController* controller = [[EditController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_个性签名页面
 *
 *  @param context
 */
- (void)showMySign:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SignController* controller = [[SignController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_性别页面
 *
 *  @param context
 */
- (void)showMySex:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    SexSelectController* controller = [[SexSelectController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_年龄页面
 *
 *  @param context
 */
- (void)showMyAge:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    AgeController* controller = [[AgeController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_地区页面
 *
 *  @param context
 */
- (void)showMyProvince:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    ProvinceController* controller = [[ProvinceController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_城市页面
 *
 *  @param context
 */
- (void)showMyCity:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    NSDictionary *dict = [dic objectForKey:ACTION_Controller_Data];
    CityController* controller = [[CityController alloc] init];
    controller.messageListner = pushController;
    controller.selectRow = [dict[SelectRow] integerValue];
    controller.titleString = dict[TitleString];
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到我家_二维码名片页面
 *
 *  @param context
 */
- (void)showMyCode:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    CodeController* controller = [[CodeController alloc] init];
    controller.messageListner = pushController;
    controller.hidesBottomBarWhenPushed = YES;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到注册_1页面
 *
 *  @param context
 */
- (void)showRegisterI:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RegisterFirstController* controller = [[RegisterFirstController alloc] init];
    controller.messageListner = pushController;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到注册_2页面
 *
 *  @param context
 */
- (void)showRegisterII:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RegisterSecondController* controller = [[RegisterSecondController alloc] init];
    controller.messageListner = pushController;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到注册_3页面
 *
 *  @param context
 */
- (void)showRegisterIII:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RegisterThirdController* controller = [[RegisterThirdController alloc] init];
    controller.messageListner = pushController;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到忘记密码_1页面
 *
 *  @param context
 */
- (void)showRevoredI:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RevordPasswordController* controller = [[RevordPasswordController alloc] init];
    controller.messageListner = pushController;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

/**
 *  跳转到忘记密码_2页面
 *
 *  @param context
 */
- (void)showRevoredII:(id)context{
    
    NSDictionary* dic = (NSDictionary*)context;
    UIViewController* pushController = [dic objectForKey:ACTION_Controller_Name];
    RevordPasswordSecondController* controller = [[RevordPasswordSecondController alloc] init];
    controller.messageListner = pushController;
    [pushController.navigationController pushViewController:controller
                                                   animated:YES];
}

@end
