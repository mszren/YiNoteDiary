//
//  ChatController.m
//  Diary
//
//  Created by 我 on 15/12/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ChatController.h"
#import "BaseNavigation.h"
#import "Masonry.h"
#import "AudioView.h"
#import "DaiDodgeKeyboard.h"
#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "UzysAssetsPickerController.h"
#import "EGOImageView.h"


#define WIDTH (Screen_Width - 100)/3
@interface ChatController ()<AudioViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UzysAssetsPickerControllerDelegate>
@property (nonatomic,strong)UzysAssetsPickerController* picker;
@property (nonatomic,strong)UIImage *publishImg;
@property (nonatomic,strong)AVAudioPlayer *publishAudio;

@end

@implementation ChatController{
    UIView *_backgroundView;
    UITextField *_editText;
    UITableView *_tableView;
    NSMutableArray  *_allMessagesFrame;
    UIBarButtonItem *_rightItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    cell.viewController = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight];
}

#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (_tableView.frame.size.height == Screen_height - 264) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            [self returnStatus];
        }];
    }else{
        
        [self.view endEditing:YES];
    }
}

#pragma mark -- AudioViewDelegate
- (void)AudioViewDelegateWithAudioFile:(NSURL *)fileUrl{
    
    [self addMessageWithContent:fileUrl time:[self currentTime]];
    [_tableView reloadData];
    [self returnStatus];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_editText resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _backgroundView.frame = CGRectMake(0, Screen_height - 114, Screen_Width, 200);
        _tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_height - 114);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        ALAsset* asset = (ALAsset*)[assets objectAtIndex:0];
        _publishImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self addMessageWithContent:_publishImg time:[self currentTime]];
        [_tableView reloadData];
        [self returnStatus];
        
    }else if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypeVideo"]){ //video
//        ALAsset* asset = (ALAsset*)[assets objectAtIndex:0];
//        ALAssetRepresentation *representation = asset.defaultRepresentation;
//        NSURL *movieURL = representation.url;
//        _publishAudio = [[AVAudioPlayer alloc]initWithContentsOfURL:movieURL error:nil];
    }
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController*)picker
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedStringFromTable(@"已经超出上传图片数量！", @"UzysAssetsPickerController", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
}

#pragma mark -- UIButton Action
- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            
            [[AudioView sharedInstance] showAudioView:self];
            [self returnStatus];
        }
            
            break;
        case 200:{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [_editText resignFirstResponder];
                _backgroundView.frame = CGRectMake(0, Screen_height - 264, Screen_Width, 200);
                _tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_height - 264);
                // 3、滚动至当前行

                
            } completion:^(BOOL finished) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
                [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }];
            
        }
            
            break;
        case 300:
        {
            
            // 1、增加数据源
            NSString *content = _editText.text;
            if (_editText.text != nil && _editText.text.length > 0) {
                
                [self addMessageWithContent:content time:[self currentTime]];
            }
            
            // 2、刷新表格
            [_tableView reloadData];
            [self returnStatus];
            _editText.text = nil;

        }
            
            break;
        case 400:{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [self returnStatus];
            } completion:^(BOOL finished) {
                
                //打开相册资源
                _picker = [[UzysAssetsPickerController alloc] init];
                _picker.maximumNumberOfSelectionVideo = 0;
                _picker.maximumNumberOfSelectionPhoto = 1;
                _picker.delegate = self;
                
                [self presentViewController:_picker
                                   animated:YES
                                 completion:^{
                                     
                                     
                                 }];
            }];
            
            
        }
            
            break;
        case 401:{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [self returnStatus];
            } completion:^(BOOL finished) {
                
                //打开视频资源
                _picker = [[UzysAssetsPickerController alloc] init];
                _picker.maximumNumberOfSelectionVideo = 1;
                _picker.maximumNumberOfSelectionPhoto = 0;
                _picker.delegate = self;
                
                [self presentViewController:_picker
                                   animated:YES
                                 completion:^{
                                     
                                     
                                 }];
                             }];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- UItouch
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {//遍历集合。touches表示所有触摸点，但是默认情况下只支持单指触摸（也就是只有一个触摸点）。
        //判断是不是点住了_backgroundView拖动
        if (touch.view != _backgroundView) {//UITouch的view属性表示正在触摸的视图
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _backgroundView.frame = CGRectMake(0, Screen_height - 114, Screen_Width, 200);
            } completion:^(BOOL finished) {
                
            }];
            
            [_editText resignFirstResponder];
        }
    }
}

#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(id)content time:(NSString *)time{
    
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    if ([content isKindOfClass:[NSString class]]) {
        msg.contentType = MessageContentFile;
        msg.content = content;
    }else if ([content isKindOfClass:[UIImage class]]){
        
        msg.contentType = MessageContentPicture;
        msg.contentImg = _publishImg;
    }else if ([content isKindOfClass:[NSURL class]]){
        
        msg.contentType = MessageContentVoice;
    }
    msg.time = time;
    msg.icon = @"icon01.png";
    msg.type = MessageTypeMe;
    mf.showTime = YES;
    mf.message = msg;
    [_allMessagesFrame addObject:mf];
}

- (NSString *)currentTime{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd HH:mm"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    return time;
}

//回复初始化状态
- (void)returnStatus{
    
    [_editText resignFirstResponder];
    _backgroundView.frame = CGRectMake(0, Screen_height - 114, Screen_Width, 50);
    _tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_height - 114);
    // 3、滚动至当前行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//初始化视图
- (void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.userInteractionEnabled = YES;
    [self addGroundView];
    [self addTableView];
}

-(void)addTableView{
    _rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_aSet up"] style:UIBarButtonItemStyleDone target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = _rightItem;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - NavigationBarHeight - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    [self.view addSubview:_tableView];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    
    _allMessagesFrame = [NSMutableArray array];
    NSString *previousTime = nil;
    for (NSDictionary *dict in array) {
        
        MessageFrame *messageFrame = [[MessageFrame alloc] init];
        Message *message = [[Message alloc] init];
        message.dict = dict;
        
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        
        messageFrame.message = message;
        
        previousTime = message.time;
        
        [_allMessagesFrame addObject:messageFrame];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//编辑视图初始化
-(void)addGroundView{
    _backgroundView = [UIView new];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.view);
        make.top.mas_equalTo(@(Screen_height - 114));
        make.height.mas_equalTo(@200);
    }];
    _backgroundView.backgroundColor = BGViewColor;
    
    UILabel *grayLabel = [UILabel new];
    [_backgroundView addSubview:grayLabel];
    [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(_backgroundView);
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 0.5));
    }];
    grayLabel.backgroundColor = BGViewLightGreen;
    
    [self addEditView];
}

//初始化编辑视图
-(void)addEditView{
    UIView *superView = _backgroundView;
    
    UIButton * audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:audioBtn];
    [audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superView.mas_left).offset(10);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.width.mas_equalTo(@30);
    }];
    audioBtn.layer.cornerRadius = 15;
    audioBtn.clipsToBounds = YES;
    audioBtn.tag = 100;
    audioBtn.adjustsImageWhenHighlighted = NO;
    [audioBtn setImage:[UIImage imageNamed:@"bg_kanzhe_fyy"] forState:UIControlStateNormal];
    [audioBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(audioBtn.mas_right).offset(10);
        make.top.mas_equalTo(superView.mas_top).offset(10);
        make.height.width.mas_equalTo(@30);
    }];
    addBtn.layer.cornerRadius = 15;
    addBtn.clipsToBounds = YES;
    addBtn.tag = 200;
    addBtn.adjustsImageWhenHighlighted = NO;
    [addBtn setImage:[UIImage imageNamed:@"bg_kanzhe_xuanze"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _editText = [UITextField new];
    [_backgroundView addSubview:_editText];
    [_editText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addBtn.mas_right).offset(10);
        make.top.mas_equalTo(addBtn);
        make.size.mas_equalTo(CGSizeMake(Screen_Width - 160, 30));
    }];
    _editText.placeholder = @"和家人说点什么吧";
    _editText.font = [UIFont systemFontOfSize:13];
    _editText.borderStyle = UITextBorderStyleRoundedRect;
    _editText.delegate = self;
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(superView.mas_right).offset(-10);
        make.top.mas_equalTo(addBtn);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [publishBtn setTitle:@"发送" forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    publishBtn.backgroundColor = BGViewGreen;
    publishBtn.adjustsImageWhenHighlighted = NO;
    publishBtn.layer.cornerRadius = 4;
    publishBtn.clipsToBounds = YES;
    publishBtn.tag = 300;
    [publishBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *selectArry = @[@"bg_kanzhe_fpic",@"bg_kanzhe_fsp"];
    for (NSInteger i = 0; i < selectArry.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backgroundView addSubview:button];
        button.tag = 400 + i;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(WIDTH + (WIDTH + 50)*i);
            make.top.mas_equalTo(87);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            
        }];
        [button setBackgroundImage:[UIImage imageNamed:selectArry[i]] forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    NSArray *namesArry = @[@"相册",@"视频"];
    for (NSInteger i = 0; i < namesArry.count; i ++) {
        UILabel *label = [UILabel new];
        [_backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WIDTH + (WIDTH + 50)*i);
            make.top.mas_equalTo(137);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        label.text = namesArry[i];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"傻不拉几~丝"];
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
}

-(void)viewWillDisappear:(BOOL)animated{
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
