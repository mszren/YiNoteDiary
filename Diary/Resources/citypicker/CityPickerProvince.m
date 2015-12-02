//
//  CityPickerProvince.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "CityPickerProvince.h"

@implementation CityPickerProvince

kInitM(province)

- (id)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.cities = dict[@"cities"];
    }
    return self;
}

@end
