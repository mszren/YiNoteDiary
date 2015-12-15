//
//  SelectAdressController.m
//  Diary
//
//  Created by 我 on 15/12/15.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "SelectAdressController.h"
#import "SelectAdressCell.h"
#import "BaseNavigation.h"

@interface SelectAdressController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *provinces;

@end

@implementation SelectAdressController{
    
    UITableView* _tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"位置"];
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
    _tableView.rowHeight = 60.5;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* selectAdressCellIdentifier = @"selectAdressCellIdentifier";
    SelectAdressCell *selectAdressCell = (SelectAdressCell *)[tableView dequeueReusableCellWithIdentifier:selectAdressCellIdentifier];
    if (!selectAdressCell) {
        selectAdressCell = [[SelectAdressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectAdressCellIdentifier];
        selectAdressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return selectAdressCell;
    
}
 

@end
