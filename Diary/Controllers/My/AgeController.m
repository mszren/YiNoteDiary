//
//  AgeController.m
//  Diary
//
//  Created by 我 on 15/11/24.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "AgeController.h"
#import "Masonry.h"
#import "BaseNavigation.h"

@interface AgeController ()
@property (nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation AgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.datePicker];
}

#pragma mark -- UIDatePicker Action
- (void)onDatapickerChange:(UIDatePicker *)picker{
 
    self.ageLabel.text = [NSString stringWithFormat:@"%ld岁",(long)[self ageWithDateOfBirth:picker.date]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"个人信息"];
    UIView *superView = self.view;
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-60);
        make.width.left.mas_equalTo(superView);
        make.height.mas_equalTo(@200);
    }];
}

//计算年龄
- (NSInteger)ageWithDateOfBirth:(NSDate*)date;
{
    
    // 出生日期转换 年月日
    NSDateComponents* components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear = [components1 year];
    NSInteger brithDateDay = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents* components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear = [components2 year];
    NSInteger currentDateDay = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (UIDatePicker *)datePicker{
    if (_datePicker == nil) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSDate *currentTime = [NSDate date];
        [_datePicker setDate:currentTime animated:YES];
        [_datePicker setMaximumDate:currentTime];
        
        
        [_datePicker addTarget:self action:@selector(onDatapickerChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _datePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
