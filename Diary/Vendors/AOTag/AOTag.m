//
//  AOTag.m
//  AOTagDemo
//
//  Created by Loïc GRIFFIE on 16/09/13.
//  Copyright (c) 2013 Appsido. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AOTag.h"

#define tagFontSize         12.0f
#define tagFontType         @"Helvetica-Light"
#define tagMarginH          20
#define tagMargin           13
#define tagHeight           15.0f
#define tagCornerRadius     3.0f
#define tagCloseButton      7.0f
#define tagSelfKW          (Screen_Width - 5*13)/4
#define tagKW              (Screen_Width - 5*13 - 32)/4
#define tagkH              ((Screen_Width - 5*13 - 32)/4 + 35)
#define tagLabelH          25.0f

@interface AOTagList ()

@property (nonatomic, strong) NSNumber *tFontSize;
@property (nonatomic, strong) NSString *tFontName;

@end

@implementation AOTagList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:BGViewColor];
        [self setUserInteractionEnabled:YES];
        
        self.tags = [NSMutableArray array];
        self.tFontSize = [NSNumber numberWithFloat:tagFontSize];
        self.tFontName = tagFontType;
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(tagMargin, 33, tagKW, tagKW);
        [_addBtn setImage:[UIImage imageNamed:@"btn_publish"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(onAddBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addBtn];
    }
    return self;
}

#pragma mark -- UIButton Action
- (void)onAddBtn:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagAddAction)])
        [self.delegate performSelector:@selector(tagAddAction) withObject:self];
}

- (void)drawRect:(CGRect)rect
{
    int n = 0;
    float x = tagMargin;
    float y = 20.0f;
    
    for (id v in [self subviews])
        if ([v isKindOfClass:[AOTag class]])
            [v removeFromSuperview];
    
    for (AOTag *tag in self.tags)
    {
        
        if (x + tagSelfKW + tagMargin > self.frame.size.width) {
            n = 0; x = tagMargin; y += tagkH + tagMargin;
        }
        else x += (n ? tagMargin : 0.0f);

        [tag setFrame:CGRectMake(x, y, tagSelfKW, tagkH)];
        [self addSubview:tag];
        
        
        x += tagSelfKW;
        
        n++;
    }
    
    float addBtnx = x;
    float addBtny = y;
    if (addBtnx + tagSelfKW + tagMargin > Screen_Width) {
        
        addBtnx = tagMargin; addBtny += tagkH + tagMargin;
    }else{
        addBtnx += tagMargin;
        addBtny = y ;
    }
    [_addBtn setFrame:CGRectMake(addBtnx, addBtny + 10, tagKW, tagKW)];
    
    CGRect r = [self frame];
    r.size.height = addBtny + tagSelfKW + tagMarginH;
    [self setFrame:r];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagUpdateFrame:)]) {
        
        [self.delegate tagUpdateFrame:r.size.height];
    }
}

- (void)setTagFont:(NSString *)name withSize:(CGFloat)size
{
    [self setTFontSize:[NSNumber numberWithFloat:size]];
    [self setTFontName:name];
}

- (AOTag *)generateTagWithLabel:(NSString *)tTitle withImage:(NSString *)tImage
{
    AOTag *tag = [[AOTag alloc] initWithFrame:CGRectZero];
    
    [tag setTFontName:self.tFontName];
    [tag setTFontSize:self.tFontSize];
    
    [tag setDelegate:self.delegate];
    [tag setTImage:[UIImage imageNamed:tImage]];
    [tag setTTitle:tTitle];
    
    [self.tags addObject:tag];
    
    return tag;
}

- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage
{
    [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tImage ? tImage : @"")];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle withImageURL:(NSURL *)imageURL andImagePlaceholder:(NSString *)tPlaceholderImage
{
    AOTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tPlaceholderImage ? tPlaceholderImage : @"")];
    [tag setTURL:imageURL];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle
     withImage:(NSString *)tImage
withLabelColor:(UIColor *)labelColor
withBackgroundColor:(UIColor *)backgroundColor
withCloseButtonColor:(UIColor *)closeColor
{
    AOTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tImage ? tImage : @"")];
    
    if (labelColor) [tag setTLabelColor:labelColor];
    if (backgroundColor) [tag setTBackgroundColor:backgroundColor];
    if (closeColor) [tag setTCloseButtonColor:closeColor];
    
    [self setNeedsDisplay];
}

- (void)addTag:(NSString *)tTitle
withImagePlaceholder:(NSString *)tPlaceholderImage
  withImageURL:(NSURL *)imageURL
withLabelColor:(UIColor *)labelColor
withBackgroundColor:(UIColor *)backgroundColor
withCloseButtonColor:(UIColor *)closeColor
{
    AOTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"") withImage:(tPlaceholderImage ? tPlaceholderImage : @"")];
    
    [tag setTURL:imageURL];
    
    if (labelColor) [tag setTLabelColor:labelColor];
    if (backgroundColor) [tag setTBackgroundColor:backgroundColor];
    if (closeColor) [tag setTCloseButtonColor:closeColor];
    
    [self setNeedsDisplay];
}

- (void)addTags:(NSArray *)tags
{
    for (NSDictionary *tag in tags)
        [self addTag:[tag objectForKey:@"title"] withImage:[tag objectForKey:@"image"]];
}

- (void)removeTag:(AOTag *)tag
{
    [self.tags removeObject:tag];
    
    [self setNeedsDisplay];
}

- (void)removeAllTag
{
    for (id t in [NSArray arrayWithArray:[self tags]])
        [self removeTag:t];
}

@end

@implementation AOTag

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, 0, Screen_Width, Screen_height);
        self.tBackgroundColor = [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000];
        self.tLabelColor = [UIColor whiteColor];
        self.tCloseButtonColor = [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000];
        
        self.tFontSize = [NSNumber numberWithFloat:tagFontSize];
        self.tFontName = tagFontType;
        
        self.tURL = nil;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        
        [[self layer] setCornerRadius:tagCornerRadius];
        [[self layer] setMasksToBounds:YES];
        
    }
    return self;
}

- (CGSize)getTagSize
{
    CGSize tSize = ([self.tTitle respondsToSelector:@selector(sizeWithAttributes:)] ? [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:self.tFontName size:[self.tFontSize floatValue]]}] : [self.tTitle sizeWithFont:[UIFont fontWithName:self.tFontName size:[self.tFontSize floatValue]]]);
    
    return CGSizeMake(tagHeight + tagMargin + tSize.width + tagMargin + tagCloseButton + tagMargin, tagHeight);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.tImageURL = [[EGOImageView alloc] initWithPlaceholderImage:self.tImage delegate:self];
    [self.tImageURL setBackgroundColor:[UIColor purpleColor]];
    self.tImageURL.layer.cornerRadius = 6;
    self.tImageURL.clipsToBounds = YES;
    self.tImageURL.layer.shouldRasterize = YES;
    self.tImageURL.userInteractionEnabled = YES;
    [self.tImageURL setFrame:CGRectMake(0.0f, 10.0f, tagKW, tagKW)];
    if (self.tURL) [self.tImageURL setImageURL:[self tURL]];
    [self addSubview:self.tImageURL];
    
    self.tSexImg = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"ic_peoplenearby"]];
    self.tSexImg.userInteractionEnabled = YES;
    [self.tSexImg setFrame:CGRectMake(0, 0, tagHeight, tagHeight)];
    [self.tSexImg setCenter:CGPointMake(tagKW, 10)];
    [self addSubview:self.tSexImg];
    
    self.tTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tagKW + 10, tagKW, tagLabelH)];
    self.tTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.tTitleLabel.font = [UIFont systemFontOfSize:14];
    self.tTitleLabel.text = self.tTitle;
    [self addSubview:self.tTitleLabel];
    
    if ([self.tTitle respondsToSelector:@selector(drawAtPoint:withAttributes:)])
    {
        [self.tTitle drawInRect:CGRectMake(tagHeight + tagMargin, ([self getTagSize].height / 2.0f) - ([self getTagSize].height / 2.0f), [self getTagSize].width, [self getTagSize].height)
             withAttributes:@{NSFontAttributeName:[UIFont fontWithName:self.tFontName size:[self.tFontSize floatValue]], NSForegroundColorAttributeName:self.tLabelColor}];
    }
    else
    {
        [self.tLabelColor set];
        [self.tTitle drawInRect:CGRectMake(tagHeight + tagMargin, ([self getTagSize].height / 2.0f) - ([self getTagSize].height / 2.0f), [self getTagSize].width, [self getTagSize].height)
                       withFont:[UIFont fontWithName:self.tFontName size:[self.tFontSize floatValue]] lineBreakMode:NSLineBreakByWordWrapping];
    }
    
//    AOTagCloseButton *close = [[AOTagCloseButton alloc] initWithFrame:CGRectMake(0.0f, 10.0f, tagKW, tagKW)];
//    close.layer.cornerRadius = 6;
//    close.clipsToBounds = YES;
//    close.layer.shouldRasterize = YES;
//    close.backgroundColor = [UIColor orangeColor];
//    [self addSubview:close];
    //删除
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClose:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.tSexImg addGestureRecognizer:recognizer];
    
    //选择
    UITapGestureRecognizer *selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.tImageURL addGestureRecognizer:selectTap];
    
//    [self addTarget:self action:@selector(tagClose:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidAddTag:)])
        [self.delegate performSelector:@selector(tagDidAddTag:) withObject:self];
}

- (void)tagSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidSelectTag:)])
        [self.delegate performSelector:@selector(tagDidSelectTag:) withObject:self];
}

- (void)tagClose:(id)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidRemoveTag:)])
        [self.delegate performSelector:@selector(tagDidRemoveTag:) withObject:self];
    
    [(AOTagList *)[self superview] removeTag:self];
}

#pragma mark - EGOImageView Delegate methods

- (void)imageViewLoadedImage:(EGOImageView *)imageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDistantImageDidLoad:)])
        [self.delegate performSelector:@selector(tagDistantImageDidLoad:) withObject:self];
}

- (void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDistantImageDidFailLoad:withError:)])
        [self.delegate performSelector:@selector(tagDistantImageDidFailLoad:withError:) withObject:self withObject:error];
}

@end

@implementation AOTagCloseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        
       
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawRect:rect];
    
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClose:)];
//    [recognizer setNumberOfTapsRequired:1];
//    [recognizer setNumberOfTouchesRequired:1];
//    [self addGestureRecognizer:recognizer];
}

- (void)tagClose:(id)sender
{
    if ([[self superview] respondsToSelector:@selector(tagClose:)])
        [[self superview] performSelector:@selector(tagClose:) withObject:self];
}

@end