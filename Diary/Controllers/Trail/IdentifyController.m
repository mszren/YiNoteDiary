//
//  IdentifyController.m
//  Diary
//
//  Created by 我 on 15/11/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "IdentifyController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "IdentifyCell.h"
#import "IdentifyHeadCell.h"
#import "IdentifyDetailController.h"
#import "BaseNavigation.h"
#import "UIImage+Utils.h"
#import "category.h"
#import "EGOImageView.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"

@interface IdentifyController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,BaseNavigationDelegate,DBCameraViewControllerDelegate>
@property (nonatomic,strong) EGOImageView *featureImg;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (strong, nonatomic) NSLayoutConstraint *headHCons;

@end

@implementation IdentifyController{
    
    UITableView* _tableView;
    CGFloat _navalpha;
    UIBarButtonItem *_nextBtn;
     DBCameraViewController *_cameraController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, -NavigationBarHeight, Screen_Width,
                                           Screen_height )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;

    _featureImg = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed: @"pic_bg"]];
    _featureImg.frame = CGRectMake(0, 0, Screen_Width, CoolNavHeight);
    _tableView.tableHeaderView = _featureImg;
    
    [self.view addSubview:_tableView];
    
    _cameraController = [DBCameraViewController initWithDelegate:self];
    [_cameraController setForceQuadCrop:YES];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:_cameraController];
    [container setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 40.5;
            break;
            
        default:
            return 94.5;
            break;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            static NSString* identifyHeadCellid = @"identifyHeadCellid";
            IdentifyHeadCell * identifyHeadCell = [tableView dequeueReusableCellWithIdentifier:identifyHeadCellid];
            if (!identifyHeadCell) {
                identifyHeadCell =
                [[IdentifyHeadCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifyHeadCellid];
                identifyHeadCell.backgroundColor = BGViewColor;
                identifyHeadCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return identifyHeadCell;
        }
            
            break;
            
        default:{
            
            static NSString* identifyCellid = @"identifyCellid";
            IdentifyCell * identifyCell = [tableView dequeueReusableCellWithIdentifier:identifyCellid];
            if (!identifyCell) {
                identifyCell =
                [[IdentifyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifyCellid];
                identifyCell.backgroundColor = BGViewColor;
                identifyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return identifyCell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        IdentifyDetailController *detailVc = [IdentifyDetailController new];
        detailVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    [category changeNacigationBarStatus:offsetY andController:self];
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有活动哦!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor greenColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

#pragma mark -- BaseNavigationDelegate
- (void)baseNavigationDelegateOnRightItemAction{
    IdentifyDetailController *detailVc = [IdentifyDetailController new];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    NSData * data = UIImageJPEGRepresentation(image, 0.08f);
    UIImage * temp = [[UIImage alloc] initWithData:data];
    [_featureImg setImage:temp];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setCleanNavigationBar:self andRightItemTitle:@"下一步" withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
