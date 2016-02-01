//
//  CusAnnotationView.m
//  Diary
//
//  Created by 我 on 15/12/8.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CusAnnotationView.h"
#import "CustomCalloutView.h"
#import "Masonry.h"



#define kWidth  106.f
#define kHeight 86.f

#define KBackgroundViewWidth 86.f
#define KBackgroundViewHeight 66.f

#define kPortraitWidth  80.f
#define kPortraitHeight 60.f

#define KCountBtnWidth 20.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CusAnnotationView ()

@end

@implementation CusAnnotationView

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name{
    return self.countBtn.titleLabel.text;
}

- (void)setName:(NSString *)name{
    [self.countBtn setTitle:name forState:UIControlStateNormal];
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //    if (self.selected == selected)
    //    {
    //        return;
    //    }
    //
    //    if (selected)
    //    {
    //        if (self.calloutView == nil)
    //        {
    //            /* Construct custom callout. */
    //            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
    //            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
    //                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
    //
    //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //            btn.frame = CGRectMake(10, 10, 40, 40);
    //            [btn setTitle:@"Test" forState:UIControlStateNormal];
    //            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //            [btn setBackgroundColor:[UIColor whiteColor]];
    //            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    //
    //            [self.calloutView addSubview:btn];
    //
    //            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
    //            name.backgroundColor = [UIColor clearColor];
    //            name.textColor = [UIColor whiteColor];
    //            name.text = @"Hello Amap!";
    //            [self.calloutView addSubview:name];
    //        }
    //
    //        [self addSubview:self.calloutView];
    //    }
    //    else
    //    {
    //        [self.calloutView removeFromSuperview];
    //    }
    //
    //    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        self.layer.shouldRasterize = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        /* Create portrait image view and add to view hierarchy. */
        self.backGroundView = [UIView new];
        [self addSubview:self.backGroundView];
        [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(KBackgroundViewWidth, KBackgroundViewHeight));
        }];
        self.backGroundView.backgroundColor = BGViewColor;
        self.backGroundView.layer.cornerRadius = 6;
        self.backGroundView.clipsToBounds = YES;

        self.portraitImageView = [UIImageView new];
        [self.backGroundView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.backGroundView);
            make.size.mas_equalTo(CGSizeMake(kPortraitWidth, kPortraitHeight));
        }];
        self.portraitImageView.layer.cornerRadius = 6;
        self.portraitImageView.clipsToBounds = YES;
        self.portraitImageView.layer.shouldRasterize = YES;
        
        
        /* Create countButton. */
        self.countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.countBtn];
        [self.countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.portraitImageView.mas_right);
            make.centerY.mas_equalTo(self.portraitImageView.mas_top);
            make.height.width.mas_equalTo(KCountBtnWidth);
        }];
        self.countBtn.layer.cornerRadius = KCountBtnWidth/2;
        self.countBtn.clipsToBounds = YES;
        self.countBtn.layer.shouldRasterize = YES;
        self.countBtn.backgroundColor = [UIColor redColor];
        self.countBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.countBtn setTitleColor:BGViewColor forState:UIControlStateNormal];
        self.countBtn.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

@end
