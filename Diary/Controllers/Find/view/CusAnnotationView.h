//
//  CusAnnotationView.h
//  Diary
//
//  Created by 我 on 15/12/8.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CusAnnotationView : MAAnnotationView

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic,strong) UIButton * countBtn;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *portrait;
@property (nonatomic, strong) UIView *calloutView;

@property (nonatomic, strong) NSString * travelId;

@property(nonatomic,strong)TravelEntity * travelEntity;
@property(nonatomic,strong)PhotoEntity * photoEntity;

@property(nonatomic,assign)NSUInteger index;

@end
