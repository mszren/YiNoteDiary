//
//  CustomAnnotationView.h
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

@property (nonatomic, strong) NSString * travelId;

@property(nonatomic,strong)TravelEntity * travelEntity;
@property(nonatomic,strong)PhotoEntity * photoEntity;

@property(nonatomic,assign)NSUInteger index;

@end
