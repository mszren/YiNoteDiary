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
#import "BaseNavigation.h"

@interface ProvinceController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *provinces;

@end

@implementation ProvinceController{
    
    UITableView* _tableView;
}
@synthesize messageListner;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    CityPickerProvince *province = _provinces[indexPath.row];
    NSDictionary *dic = @{ACTION_Controller_Name : self ,ACTION_Controller_Data : @{SelectRow : @(indexPath.row), TitleString : province.name}};
    [self RouteMessage:ACTION_SHOW_MY_CITY withContext:dic];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"地区"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
IMPLEMENT_MESSAGE_ROUTABLE


@end
