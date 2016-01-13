//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"
#import "Masonry.h"
#import "ToastManager.h"

#define OtherHeight  40
static const CGFloat labelPadding = 10;

// Private
@interface MWCaptionView () <UITextViewDelegate>
{
    id <MWPhoto> _photo;
    UILabel *_label;
    UILabel *_timeLabel;
    UIImageView *_addressImg;
    UILabel *_addressLabel;
    UIView *_backView;
    UIButton *_cancelBtn;
    UIButton *_certainBtn;
    UILabel *_titleLabel;
    UITextView *_textView;
    UILabel *_coverLabel;
    int _height;
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, Screen_Width, 44 + OtherHeight)]; // Random initial frame
    if (self) {
        
        self.userInteractionEnabled = YES;
        _photo = photo;
        self.barStyle = UIBarStyleBlackTranslucent;
        self.tintColor = nil;
        self.barTintColor = nil;
        self.barStyle = UIBarStyleBlackTranslucent;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_label.font}
                                                context:nil].size;
    return CGSizeMake(size.width, textSize.height + labelPadding * 2 + OtherHeight);
}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                       self.bounds.size.width-labelPadding*2,
                                                       self.bounds.size.height - OtherHeight))];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;

    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:17];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    [self addSubview:_label];
    if ([_photo respondsToSelector:@selector(isUserInterAction)]) {
        _label.userInteractionEnabled = [_photo isUserInterAction] ? [_photo isUserInterAction] : NO;
    }
    [_label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)]];
    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake(labelPadding, self.bounds.size.height - OtherHeight + 10, 150, 15))];
    _timeLabel.opaque = NO;
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:15];
    if ([_photo respondsToSelector:@selector(captionTime)]) {
        _timeLabel.text = [_photo captionTime] ? [_photo captionTime] : @" ";
    }
    [self addSubview:_timeLabel];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake([UIScreen mainScreen].bounds.size.width - labelPadding - 120, self.bounds.size.height - OtherHeight + 10, 120, 15))];
    _addressLabel.opaque = NO;
    _addressLabel.backgroundColor = [UIColor clearColor];
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    if ([_photo respondsToSelector:@selector(captionAdress)]) {
        _addressLabel.text = [_photo captionAdress] ? [_photo captionAdress] : @" ";
    }
    [self addSubview:_addressLabel];
    
    _addressImg = [[UIImageView alloc]initWithFrame:CGRectIntegral(CGRectMake(_addressLabel.frame.origin.x - 25 , self.bounds.size.height - OtherHeight + 8, 20, 20))];
    _addressImg.opaque = NO;
    if ([_photo respondsToSelector:@selector(captionAdress)]) {
        _addressImg.image = [_photo captionAdress] ? [UIImage imageNamed:@"ic_landmark"] : [UIImage imageNamed:@""];
    }
    [self addSubview:_addressImg];
    
    
    _backView = [[UIView alloc]initWithFrame:CGRectIntegral(CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))];
    _backView .opaque = NO;
    _backView.backgroundColor = [UIColor blackColor];
    [self addSubview:_backView];
    [_backView setHidden:YES];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectIntegral(CGRectMake(labelPadding, 5, 20, 20));
    [_cancelBtn setImage:[UIImage imageNamed:@"ic_aSet up"] forState:UIControlStateNormal];
    _cancelBtn.tag = 100;
    [_cancelBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_cancelBtn];
    
    _certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _certainBtn.frame = CGRectIntegral(CGRectMake(self.bounds.size.width - labelPadding - 20, 5, 20, 20));
    [_certainBtn setImage:[UIImage imageNamed:@"ic_aSet up"] forState:UIControlStateNormal];
    _certainBtn.tag = 101;
    [_certainBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_certainBtn];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake(0, 5, 60, 20))];
    _titleLabel.center = CGPointMake(self.bounds.size.width/2.0, 20);
    _titleLabel.opaque = NO;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = BGViewColor;
    _titleLabel.font = FONT_SIZE_15;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"描述编辑";
    [_backView addSubview:_titleLabel];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 30, self.bounds.size.width - 2*labelPadding, 40))];
    _textView.layer.cornerRadius = 4;
    _textView.clipsToBounds = YES;
    _textView.layer.borderWidth = 1;
    _textView.layer.shouldRasterize = YES;
    _textView.layer.borderColor = BGViewColor.CGColor;
    _textView.opaque = NO;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = BGViewColor;
    _textView.font = FONT_SIZE_15;
    _textView.delegate = self;
    [_backView addSubview:_textView];
    
    _coverLabel = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake(7, 8, 150, 15))];
    _coverLabel.text = @"把你想说的话写下来吧...";
    _coverLabel.opaque = NO;
    _coverLabel.backgroundColor = [UIColor clearColor];
    _coverLabel.textColor= BGViewColor;
    _coverLabel.font = FONT_SIZE_15;
    [_textView addSubview:_coverLabel];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    _textView.text = textView.text;
    if (_textView.text.length == 0)
        _coverLabel.text = @"把你想说的话写下来吧...";
    else
        _coverLabel.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView{

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [_textView resignFirstResponder];
        [self.delegate mwCaptionViewDelegateKeYboardHeight:0 andIndex:_index];
        return NO;
    }
    else
        return YES;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    //获取键盘的高度
    NSDictionary* userInfo = [aNotification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _height = keyboardRect.size.height;
    [self.delegate mwCaptionViewDelegateKeYboardHeight:_height andIndex:_index];
}

#pragma mark - UIButton Action
- (void)onBtn:(UIButton *)sender{
    
    [_textView resignFirstResponder];
    [self.delegate mwCaptionViewDelegateKeYboardHeight:0 andIndex:_index];
    [_backView setHidden:YES];
    switch (sender.tag) {
        case 100:
            _label.text = @"把你想说的话写下来吧...";
            break;
            
        default:{
            if (_textView.text.length == 0) {
                [ToastManager showToast:@"请输入描述内容" withTime:Toast_Hide_TIME];
                return;
            }else{
                
                _label.text = _textView.text;
            }
        }
            break;
    }
}

#pragma mark - UITapGestureRecognizer Action
- (void)onTap{
    
    [_backView setHidden:NO];
}

@end
