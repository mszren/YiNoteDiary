//
//  UIImage+Scale.h
//  Core
//
//  Created by qluo on 11/9/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage*)scaleClipToSize:(CGSize)size;//scale and get sub

@end
