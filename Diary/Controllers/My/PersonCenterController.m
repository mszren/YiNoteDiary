//
//  PersonCenterController.m
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "PersonCenterController.h"
#import "EditController.h"
#import "SignController.h"
#import "SexSelectController.h"
#import "AgeController.h"
#import "ProvinceController.h"
#import "CodeController.h"

@interface PersonCenterController ()

@end

@implementation PersonCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.title = @"个人中心";
    self.scrollView.contentSize = CGSizeMake(Screen_Width, self.outBtn.frame.size.height + self.outBtn.frame.origin.y + 10);
    
    self.faceView.userInteractionEnabled = YES;
    UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    self.faceImg.userInteractionEnabled = YES;
    [self.faceImg addGestureRecognizer:faceTap];
    
    UITapGestureRecognizer *nichengTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.nichengView addGestureRecognizer:nichengTap];
    
    UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.signView addGestureRecognizer:signTap];
    
    UITapGestureRecognizer *sexTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.sexView addGestureRecognizer:sexTap];
    
    UITapGestureRecognizer *ageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.ageView addGestureRecognizer:ageTap];
    
    UITapGestureRecognizer *adressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.adressView addGestureRecognizer:adressTap];
    
    UITapGestureRecognizer *codeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.codeView addGestureRecognizer:codeTap];
    
    
}

#pragma mark -- UITapGestureRecognizer
- (void)onTap:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 100:{
            
            EditController *editVc = [EditController new];
            editVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:editVc animated:YES];
        }
            
            break;
        case 101:{
            
            SignController *signVc = [SignController new];
            signVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:signVc animated:YES];
        }
            
            break;
        case 102:{
            
            SexSelectController *sexVc = [SexSelectController new];
            sexVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sexVc animated:YES];
        }
            
            break;
        case 103:{
            
            AgeController *ageVc = [AgeController new];
            ageVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ageVc animated:YES];
        }
            
            break;
        case 104:{
            
            ProvinceController *provinceVc = [ProvinceController new];
            provinceVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:provinceVc animated:YES];
        }
            
            break;
        case 105:{
            
            CodeController *codeVc = [CodeController new];
            codeVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:codeVc animated:YES];
        }
            
            break;
        default:{
            
            [self creatAlertView];
        }
            break;
    }
}

- (void)creatAlertView{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"图库上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        
    }]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
