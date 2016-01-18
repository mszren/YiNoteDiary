//
//  UIImage+Scale.m
//  Core
//
//  Created by qluo on 11/9/12.
//
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

//截取部分图像 
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if (size.width > 0 && size.height > 0)
    {
        UIGraphicsBeginImageContext(size);
        
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    else
    {
        return nil;
    }
}

//等比例缩放, 并且取其中的一部分
-(UIImage*)scaleClipToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if (size.width > 0 && size.height > 0 && (self.size.width != 0))
    {
        CGFloat imageScaleWidth = size.width;
        CGFloat factor = self.size.height / self.size.width;
        CGFloat imageScaleHeight = floorf(size.width * (factor));
        
        UIGraphicsBeginImageContext(size);
        
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(0, 0, imageScaleWidth, imageScaleHeight)];
        UIRectClip(CGRectMake(0, 0, size.width, size.height));
        
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    else
    {
        return nil;
    }
}

//等比例缩放, 并且取其中的一部分
-(UIImage*)clipToSize:(CGSize)size
{
    if (size.width > 0 && size.height > 0)
    {
        UIGraphicsBeginImageContext(size);
        
        [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        UIRectClip(CGRectMake(0, 0, size.width, size.height));
        
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    else
    {
        return nil;
    }
    
}

@end
