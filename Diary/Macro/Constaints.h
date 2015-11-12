//
//  Constaints.h
//  Diary
//
//  Created by Owen on 15/10/30.
//  Copyright © 2015年 Owen. All rights reserved.
//

#ifndef Constaints_h
#define Constaints_h


// COLOR
#define RGBCOLOR(r, g, b)                                                      \
[UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define RGBACOLOR(r, g, b, a)                                                  \
[UIColor colorWithRed:(r) / 255.0                                            \
green:(g) / 255.0                                            \
blue:(b) / 255.0                                            \
alpha:(a)]

#define Toast_Hide_TIME 1

#define NavBarBgColor RGBCOLOR(135, 213, 27)
#define TabBarColor RGBCOLOR(239, 239, 239)


//背景
#define BGViewColor RGBCOLOR(255, 255, 255)
#define BGViewGray RGBCOLOR(242, 242, 242)
#define COLOR_GRAY_DEFAULT_185 RGBACOLOR(185, 185, 185, 1)
#define COLOR_GRAY_DEFAULT_30 RGBACOLOR(30, 30, 30, 1)

#endif /* Constaints_h */
