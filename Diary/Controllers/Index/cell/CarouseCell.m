//
//  CarouseCell.m
//  Diary
//
//  Created by 我 on 15/11/12.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CarouseCell.h"
#import "EGOImageView.h"

@implementation CarouseCell{
    
    UIScrollView* _carouselScrollView;
    UIPageControl* _pageControl;
    EGOImageView* _carouseImage1;
    EGOImageView* _carouseImage2;
    EGOImageView* _carouseImage3;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //添加定时器
        [NSTimer scheduledTimerWithTimeInterval:3
                                         target:self
                                       selector:@selector(runTimePage)
                                       userInfo:nil
                                        repeats:YES];
        
        //滚动视图
 
        
        _carouselScrollView = [[UIScrollView alloc]
                               initWithFrame:CGRectMake(0, 0, Screen_Width, 124 * (Screen_Width / 320))];
        
        _carouselScrollView.showsVerticalScrollIndicator = NO;
        _carouselScrollView.showsHorizontalScrollIndicator = NO;
        _carouselScrollView.delegate = self;
        _carouselScrollView.pagingEnabled = YES;
        _carouselScrollView.bounces = NO;
        _carouselScrollView.userInteractionEnabled = YES;
        [self addSubview:_carouselScrollView];
        
        
        _carouseImage1 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"bg_wojia"]];
        _carouseImage1.frame = CGRectMake(0, 0, Screen_Width, 124 * (Screen_Width / 320));
        _carouseImage1.tag = 100;
        _carouseImage1.userInteractionEnabled = YES;
        [_carouselScrollView addSubview:_carouseImage1];
        
        _carouseImage2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"img_saisai_hdzt2"]];
        _carouseImage2.frame = CGRectMake(Screen_Width, 0, Screen_Width, 124 * (Screen_Width / 320));
        _carouseImage2.tag = 101;
        _carouseImage2.userInteractionEnabled = YES;
        [_carouselScrollView addSubview:_carouseImage2];
        
        _carouseImage3 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"pic_bg@2x"]];
        _carouseImage3.frame = CGRectMake(2 * Screen_Width, 0, Screen_Width, 124 * (Screen_Width / 320));
        _carouseImage3.tag = 102;
        _carouseImage3.userInteractionEnabled = YES;
        [_carouselScrollView addSubview:_carouseImage3];
        
        _carouselScrollView.contentSize = CGSizeMake(3 * Screen_Width, 0);
        _carouselScrollView.contentOffset = CGPointMake(0, 0);
        
        //创建pageControl
        _pageControl = [[UIPageControl alloc]
                        initWithFrame:CGRectMake((Screen_Width - 40)/2 - 20, 124 * (Screen_Width / 320)  - 20, 40, 20)];
        
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = BGViewColor;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [scrollView
     setContentOffset:CGPointMake(scrollView.bounds.size.width * page, 0)
     animated:YES];
    
    _pageControl.currentPage = page;
 
}

//定时器绑定方法
- (void)runTimePage
{
    
    NSInteger page = (_pageControl.currentPage + 1) % 3; // 获取当前的page
    _pageControl.currentPage = page;
    [_carouselScrollView
     setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width * page,
                                  0)
     animated:YES];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
