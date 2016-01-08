//
//  MessageController.m
//  Diary
//
//  Created by Owen on 15/11/4.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "MessageController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "NewsCell.h"
#import "NotifationCell.h"
#import "PersonCell.h"
#import "AdressBookController.h"
#import "NotifationController.h"
#import "BaseNavigation.h"
#import "ChatToolController.h"

@interface MessageController () <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation MessageController{
    
    UITableView* _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{

    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height - NavigationBarHeight - statusHeight )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.emptyDataSetSource = self;
    _tableView.backgroundColor = BGViewGray;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 56.5;
            break;
            
        case 1:
            return 69;
            break;
            
        default:
            return 66.5;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            static NSString* notifationCellid = @"notifationCellid";
            NotifationCell * notifationCell = [tableView dequeueReusableCellWithIdentifier:notifationCellid];
            if (!notifationCell) {
                notifationCell =
                [[NotifationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:notifationCellid];
                notifationCell.backgroundColor = BGViewColor;
                notifationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return notifationCell;
        }
            
            break;
        case 1:{
            
            static NSString* personCellid = @"personCellid";
            PersonCell * personCell = [tableView dequeueReusableCellWithIdentifier:personCellid];
            if (!personCell) {
                personCell =
                [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:personCellid];
                personCell.backgroundColor = BGViewColor;
                personCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return personCell;
        }
            
            break;
            
        default:{
            
            static NSString* newsCellid = @"newsCellid";
            NewsCell * newsCell = [tableView dequeueReusableCellWithIdentifier:newsCellid];
            if (!newsCell) {
                newsCell =
                [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:newsCellid];
                newsCell.backgroundColor = BGViewColor;
                newsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return newsCell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
            NotifationController *notifationVc = [NotifationController new];
            notifationVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:notifationVc animated:YES];
        }
            
            break;
        case 1:{
            
            AdressBookController *adressBookVc = [AdressBookController new];
            adressBookVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:adressBookVc animated:YES];
        }
            break;
            
        default:{
            
            ChatToolController *chatVc = [ChatToolController new];
            chatVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatVc animated:YES];
        }
            break;
    }
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setIndexGreenNavigationBar:self andTitle:@"消息"];
}

@end
