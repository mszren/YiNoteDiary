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

#define OtherHeight  40
static const CGFloat labelPadding = 10;

// Private
@interface MWCaptionView () {
    id <MWPhoto> _photo;
    UILabel *_label;
    UILabel *_timeLabel;
    UIImageView *_addressImg;
    UILabel *_addressLabel;
}
@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44 + OtherHeight)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
        self.barStyle = UIBarStyleBlackTranslucent;
        self.tintColor = nil;
        self.barTintColor = nil;
        self.barStyle = UIBarStyleBlackTranslucent;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
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
    
}


@end
