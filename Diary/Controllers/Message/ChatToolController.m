//
//  ChatToolController.m
//  Diary
//
//  Created by 我 on 15/12/19.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ChatToolController.h"
#import "BaseNavigation.h"
#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "CSChatToolView.h"

@interface ChatToolController () <UITableViewDataSource,UITableViewDelegate,CSChatToolViewKeyboardProtcol>
@property (strong ,nonatomic) CSChatToolView *chatView;

@end

@implementation ChatToolController{
     UITableView *_tableView;
     NSMutableArray  *_allMessagesFrame;
     UIBarButtonItem *_rightItem;
}

#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        _chatView = [[CSChatToolView alloc]initWithObserver:self andViewController:self];
        [self initTableView];

    }
    return self;
}

-(void)initTableView{
    
    
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
    
    [self.view addSubview:_chatView];
    
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
    
    UITapGestureRecognizer *tapReturnKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKeyBoard:)];
    [_tableView addGestureRecognizer:tapReturnKeyBoard];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_chatView.contentTextView resignFirstResponder];
}

#pragma mark CSChatToolView_Delegate
- (void)chatKeyboardWillShow:(CGFloat)keyBoardHeight{
    [UIView animateWithDuration:0.4 animations:^{
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, 0 - keyBoardHeight, _tableView.frame.size.width, _tableView.frame.size.height)];
    }];
}
- (void)chatKeyboardWillHide{
    [UIView animateWithDuration:0.4 animations:^{
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, 0, _tableView.frame.size.width, _tableView.frame.size.height)];
    }];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightItem:(UIBarButtonItem *)sender{
    
}

#pragma mark -- UITapGestureRecognizer
- (void)returnKeyBoard:(id)sender
{
    [_chatView.contentTextView resignFirstResponder];
}

//回复初始化状态
- (void)returnStatus{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark -- CSChatToolViewKeyboardProtcol
- (void)sendMessageWithText:(id)text{
    
    [self addMessageWithContent:text time:[self currentTime]];
    [_tableView reloadData];
    [_tableView scrollRectToVisible:CGRectMake(0, _tableView.contentSize.height - 15, _tableView.frame.size.width, 10) animated:YES];
}

- (void)sendSoundWithData:(NSData *)data{
    
}

#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(id)content time:(NSString *)time{
    
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    if ([content isKindOfClass:[NSString class]]) {

        msg.content = content;
        msg.contentType = MessageContentFile;
 
    }else if ([content isKindOfClass:[UIImage class]]){
        
        msg.contentType = MessageContentPicture;
        msg.contentImg = (UIImage *)content;
    }else if ([content isKindOfClass:[NSURL class]]){
        
        msg.contentType = MessageContentVoice;
    }
    msg.time = time;
    msg.icon = @"icon01.png";
    msg.type = MessageTypeMe;
    mf.showTime = YES;
    mf.message = msg;
    [_allMessagesFrame addObject:mf];
    [_tableView reloadData];
    [self returnStatus];
}


- (NSString *)currentTime{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd HH:mm"; // @"yyyy-MM-dd HH:mm:ss"
    NSString *time = [fmt stringFromDate:date];
    return time;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"傻不拉几~丝"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
