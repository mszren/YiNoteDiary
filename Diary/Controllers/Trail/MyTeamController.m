//
//  MyTeamController.m
//  Diary
//
//  Created by 我 on 15/12/31.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "MyTeamController.h"
#import "BaseNavigation.h"
#import "TrailSetController.h"
#import "AOTag.h"
#import "OtherTrailController.h"
#import "LocationManager.h"

#define tagMargin           13
#define tagKW              (Screen_Width - 5*13 - 32)/4
@interface MyTeamController () <AOTagDelegate>
@property (nonatomic, strong) AOTagList *tag;
@property (nonatomic, strong) NSMutableArray *randomTag;
@property(nonatomic, strong) NSMutableArray *dataList;

@end

@implementation MyTeamController{
    
    UIBarButtonItem* _rightButton;
    UIButton *_addBtn;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

- (void)initView{
    _rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_aSet up"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = BGViewColor;
    
    [self resetRandomTagsName];
    
    self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0,
                                                           0,
                                                           Screen_Width,
                                                           Screen_height)];
    
    [self.tag setDelegate:self];
    [self.view addSubview:self.tag];
    
    _dataList = [[TrailDataCenter shareInstance] loadTravelListData];
}

- (void)resetRandomTagsName
{
    [self.tag removeAllTag];
    
    self.randomTag = [NSMutableArray arrayWithArray:@[@{@"title": @"Tyrion", @"image": @"pic_bg"}, @{@"title": @"Jaime", @"image": @"pic_bg"}, @{@"title": @"Robert", @"image": @"pic_bg"}, @{@"title": @"Sansa", @"image": @"pic_bg"}, @{@"title": @"Arya", @"image": @"pic_bg"}, @{@"title": @"Jon", @"image": @"pic_bg"}, @{@"title": @"Catelyn", @"image": @"pic_bg"}, @{@"title": @"Cersei", @"image": @"pic_bg"}]];
}

#pragma mark -- AOTagDelegate
- (void)tagAddAction{
    
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"] withImage:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]];
        [self.randomTag removeObjectAtIndex:index];
    }    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)tagDidRemoveTag:(AOTag *)tag{
    
}

- (void)tagDidSelectTag:(AOTag *)tag{


    TravelRecord * aModel = [[TravelRecord alloc] initWithName:@"北京" logo:@"北京" travelDesc:@"北京__故宫"];
    aModel.createTime = [NSDate currentTime];
    aModel.startLatitude = [LocationManager shareInstance].currentCoord.latitude;
    aModel.startLongitude = [LocationManager shareInstance].currentCoord.longitude;
    
    if ([[TrailDataCenter shareInstance] insertTravelRecord:aModel]) {
        TravelRecord * temp = [[TrailDataCenter shareInstance] selectTravelRecordByuuid:aModel.uuid];
        NSDictionary * dic = @{ACTION_Controller_Name : self ,ACTION_Controller_Data : @{CurrentTravelEntity : temp}};
        [self RouteMessage:ACTION_SHOW_OTHERTRAIL withContext:dic];
    }
}

- (NSUInteger)getRandomTagIndex
{
    return arc4random() % [self.randomTag count];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{

    NSDictionary * dic = @{ACTION_Controller_Name : self};
    [self RouteMessage:ACTION_SHOW_TRAILSET withContext:dic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的队员"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE

@end
