//
//  ProvinceController.m
//  Diary
//
//  Created by 我 on 15/12/2.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ProvinceController.h"
#import "ProvinceCell.h"
#import "CityPickerProvince.h"
#import "CityController.h"

@interface ProvinceController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *provinces;

@end

@implementation ProvinceController{
    
    UITableView* _tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    self.title = @"地区";
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _provinces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* provinceCellIdentifier = @"provinceCellIdentifier";
    ProvinceCell *provinceCell = (ProvinceCell *)[tableView dequeueReusableCellWithIdentifier:provinceCellIdentifier];
    if (!provinceCell) {
        provinceCell = [[[NSBundle mainBundle] loadNibNamed:@"ProvinceCell" owner:self options:nil]lastObject];
        provinceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [provinceCell setProvince:_provinces[indexPath.row]];
    return provinceCell;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityController *cityVc = [CityController new];
    cityVc.selectRow = indexPath.row;
    CityPickerProvince *province = _provinces[indexPath.row];
    cityVc.titleString = province.name;
    [self.navigationController pushViewController:cityVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
