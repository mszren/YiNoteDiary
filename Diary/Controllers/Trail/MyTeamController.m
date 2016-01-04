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

#define tagMargin           13
#define tagKW              (Screen_Width - 5*13 - 32)/4
@interface MyTeamController () <AOTagDelegate>
@property (nonatomic, strong) AOTagList *tag;
@property (nonatomic, strong) NSMutableArray *randomTag;

@end

@implementation MyTeamController{
    
    UIBarButtonItem* _rightButton;
    UIButton *_addBtn;
}

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
    OtherTrailController *otherTrailVc = [OtherTrailController new];
    otherTrailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:otherTrailVc animated:YES];
}

- (NSUInteger)getRandomTagIndex
{
    return arc4random() % [self.randomTag count];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    TrailSetController *trailSetVc = [TrailSetController new];
    trailSetVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:trailSetVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"我的队员"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
