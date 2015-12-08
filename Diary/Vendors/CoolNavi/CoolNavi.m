//
//  CoolNavi.m
//  Diary
//
//  Created by 我 on 15/12/7.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CoolNavi.h"
#import "UIImageView+WebCache.h"
@interface CoolNavi()

@property (nonatomic, strong) UIImageView *backgroundImg;
@property (nonatomic, assign) CGPoint prePoint;

@end

@implementation CoolNavi

- (id)initWithFrame:(CGRect)frame backGroudImage:(NSString *)backImageName 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5*frame.size.height, frame.size.width, frame.size.height*1.5)];
        _backgroundImg.image = [UIImage imageNamed:backImageName];
        _backgroundImg.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImg.clipsToBounds = YES;
        [self addSubview:_backgroundImg];
        
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)removeObserver{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:Nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0 , 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
}

-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset
{
    
    CGFloat destinaOffset = -84;
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    newOffset = CGPointMake(newOffset.x, newOffset.y<startChangeOffset?startChangeOffset:(newOffset.y>destinaOffset?destinaOffset:newOffset.y));
    
    CGFloat newY = -newOffset.y-self.scrollView.contentInset.top;
    CGFloat d = destinaOffset-startChangeOffset;
    CGFloat alpha = 1-(newOffset.y-startChangeOffset)/d;

    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
    self.backgroundImg.frame = CGRectMake(0, -0.5*self.frame.size.height+(1.5*self.frame.size.height-64)*(1-alpha), self.backgroundImg.frame.size.width, self.backgroundImg.frame.size.height);
}

@end
