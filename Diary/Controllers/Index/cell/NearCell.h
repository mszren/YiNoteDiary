//
//  NearCell.h
//  Diary
//
//  Created by 我 on 15/11/12.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NearCellDelegate <NSObject>

- (void)cellHeight:(CGFloat)height;

@end

@interface NearCell : UITableViewCell
@property (nonatomic,weak)id<NearCellDelegate>delegate;

- (void)bindData:(NSInteger)count;
@end
