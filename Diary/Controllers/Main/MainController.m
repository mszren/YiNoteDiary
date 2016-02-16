//
//  MainController.m
//  Diary
//
//  Created by Owen on 15/11/3.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "MainController.h"
#import "IndexController.h"
#import "FindController.h"
#import "TrailController.h"
#import "MessageController.h"
#import "MyController.h"
#import "SPKitExample.h"
#import <WXOUIModule/YWConversationListViewController.h>
#import <WXOUIModule/IYWUIService.h>
#import "ActionHandler.h"

@interface MainController ()
   @property (nonatomic,copy) UINavigationController *indexNavController;
   @property (nonatomic,copy)  UINavigationController *findNavController;
   @property (nonatomic,copy)  UINavigationController *trailNavController;
   @property (nonatomic,copy) UINavigationController *messageNavController;
   @property (nonatomic,copy)  UINavigationController *myNavController;
   @property (nonatomic,copy)  ActionHandler *actionHandler;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _actionHandler = [[ActionHandler alloc] init];
    self.viewControllers=@[self.indexNavController,self.findNavController,self.trailNavController,self.messageNavController,self.myNavController];
    [self initView];
}


-(void) initView{
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    UIImage *item1Image = [UIImage imageNamed:@"tabbar_home_selected"];
    item1Image =
    [item1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = item1Image;
    [item1 setImage:[UIImage imageNamed:@"tabbar_home_normal"]];
    item1.title = @"首页";
    
    
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    UIImage *item2Image = [UIImage imageNamed:@"tabbar_find_selected"];
    item2Image =
    [item2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = item2Image;
    [item2 setImage:[UIImage imageNamed:@"tabbar_find_normal"]];
    item2.title = @"发现";
    
    
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:2];
    UIImage *item3Image = [UIImage imageNamed:@"tabbar_Locus_selected"];
    item3Image =
    [item3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = item3Image;
    [item3 setImage:[UIImage imageNamed:@"tabbar_Locus_normal"]];
    item3.title = @"轨迹";
    
    
    UITabBarItem *item4 = [self.tabBar.items objectAtIndex:3];
    UIImage *item4Image = [UIImage imageNamed:@"tabbar_news_selected"];
    item4Image =
    [item4Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = item4Image;
    [item4 setImage:[UIImage imageNamed:@"tabbar_news_normal"]];
    item4.title = @"消息";
    
    
    UITabBarItem *item5 = [self.tabBar.items objectAtIndex:4];
    UIImage *item5Image = [UIImage imageNamed:@"tabbar_mine_selected"];
    item5Image =
    [item5Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = item5Image;
    [item5 setImage:[UIImage imageNamed:@"tabbar_mine_normal"]];
    item5.title = @"我的";
    
    self.tabBar.tintColor = NavBarBgColor;
    self.tabBar.barTintColor = TabBarColor;
    
}
#pragma mark -
#pragma mark UITabBarController Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark RoutedMessages
- (void)RouteMessage:(NSString*)message withContext:(id)context
{
    
    [_actionHandler excuteAction:message context:context];
}

#pragma mark -
#pragma mark getters and setters

-(UINavigationController*)indexNavController{
    if (_indexNavController==nil) {
        
        IndexController *indexController=[[IndexController alloc] init];
        indexController.messageListner = self;
        _indexNavController=[[UINavigationController alloc] initWithRootViewController:indexController];
    }
    return _indexNavController;
}

-(UINavigationController*)findNavController{
    if (_findNavController==nil) {
        
        FindController *findController=[[FindController alloc] init];
        findController.messageListner = self;
        _findNavController=[[UINavigationController alloc] initWithRootViewController:findController];
    }
    return _findNavController;
}

-(UINavigationController*)trailNavController{
    if (_trailNavController==nil) {
        
        TrailController *trailController=[[TrailController alloc] init];
        trailController.messageListner = self;
        _trailNavController=[[UINavigationController alloc] initWithRootViewController:trailController];
    }
    return _trailNavController;
}

-(UINavigationController*)messageNavController{
    if (_messageNavController==nil) {
        MessageController *messageController=[[MessageController alloc] init];
        messageController.messageListner = self;
        _messageNavController=[[UINavigationController alloc] initWithRootViewController:messageController];
        
    }
    return _messageNavController;
}

-(UINavigationController*)myNavController{
    if (_myNavController==nil) {
        MyController *myController=[[MyController alloc] init];
        myController.messageListner = self;
        _myNavController=[[UINavigationController alloc] initWithRootViewController:myController];
    }
    return _myNavController;
}

@end
