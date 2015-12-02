//
//  ProvinceCell.h
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerProvince.h"

@interface ProvinceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;

- (void)setProvince:(CityPickerProvince *)province;
 
@end
