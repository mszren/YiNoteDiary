//
//  CityController.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "CityController.h"
#import "CityPickerProvince.h"
#import "CityCell.h"
#import "BaseNavigation.h"

@interface CityController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *provinces;

@end

@implementation CityController{
    
    UITableView* _tableView;
    CityPickerProvince *_cityPicker;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [BaseNavigation setGreenNavigationBar:self andTitle:self.titleString];
    [self initView];
}

- (void)initView{
    
    self.view.backgroundColor = BGViewGray;
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, Screen_Width,
                                           Screen_height  )
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 61;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    // 初始化模型数据
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    _provinces = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CityPickerProvince *province = [CityPickerProvince provinceWithDict:dict];
        [_provinces addObject:province];
    }
    
    _cityPicker = _provinces[self.selectRow];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cityPicker.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cityCellidentifier = @"cityCellidentifier";
    CityCell *cityCell = (CityCell *)[tableView dequeueReusableCellWithIdentifier:cityCellidentifier];
    if (!cityCell) {
        cityCell = [[[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:self options:nil]lastObject];
        cityCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cityCell setCity:_cityPicker.cities[indexPath.row]];
    return cityCell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
