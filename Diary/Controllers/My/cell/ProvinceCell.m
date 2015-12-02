//
//  ProvinceCell.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ProvinceCell.h"

@implementation ProvinceCell

- (void)setProvince:(CityPickerProvince *)province{
    self.provinceLabel.text = province.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
