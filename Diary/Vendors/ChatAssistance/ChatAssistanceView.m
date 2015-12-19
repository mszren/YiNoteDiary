//
//  ChatAssistanceView.m
//  CSChatDemo
//
//  Created by 李赐岩 on 15/11/21.
//  Copyright © 2015年 Chausson. All rights reserved.
//

#import "ChatAssistanceView.h"
#import "ChatAssistanceModel.h"
#import "UzysAssetsPickerController.h"

#define CHARTASSISTACED @"ChatResourse"

#define SCREENWIDTH  ( [UIScreen mainScreen].bounds.size.width )

#define SCREENHEIGHT ( [UIScreen mainScreen].bounds.size.height)

#define CHATASSISTANCE_COUNT_ROW 2 // 行数

#define CHATASSISTANCE_COUNT_CLU 4 // 每行个数

#define CHATASSISTANCE_ITEM_SIZE 58 * SCREENHEIGHT / 667

#define CHATASSISTANCE_COUNT_PAGE (CHATASSISTANCE_COUNT_ROW * CHATASSISTANCE_COUNT_CLU)

#define ITEM_DISTANCE_SIZE 20 * SCREENWIDTH / 375
@interface ChatAssistanceView ()<UIScrollViewDelegate,UzysAssetsPickerControllerDelegate>{
    UIScrollView *chatAssistanceScrollView;
    GrayPageControl *assistancePageControl;
    ChatAssistanceModel *assistanceM;
    NSMutableArray *assistanceItemArray;
    UzysAssetsPickerController* _picker;
}

@end

@implementation ChatAssistanceView

-(instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self getAssistancePagecontrol];
        [self layOutSubView];
    }
    return self;
}

#pragma mark privite getAssistanceDic
- (void) getAssistancePagecontrol
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: CHARTASSISTACED ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSError *error;
    assistanceM = [[ChatAssistanceModel alloc] initWithDictionary:dic error:&error];
    assistanceItemArray = [NSMutableArray array];
    for (ChatAssistanceitemModel *assistanceItem in assistanceM.moreItems) {
        [assistanceItemArray addObject:assistanceItem];
    }
}

#pragma mark privite layOutSubviews
- (void) layOutSubView
{
    chatAssistanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
    chatAssistanceScrollView.pagingEnabled = YES;
    chatAssistanceScrollView.contentSize = CGSizeMake((assistanceItemArray.count / CHATASSISTANCE_COUNT_PAGE + 1) * SCREENWIDTH, 190);
    chatAssistanceScrollView.showsHorizontalScrollIndicator = NO;
    chatAssistanceScrollView.showsVerticalScrollIndicator = NO;
    chatAssistanceScrollView.delegate = self;
    
    for (int i = 0; i < assistanceItemArray.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel *itemLabel = [UILabel new];
        [itemButton addTarget:self action:@selector(itemButton:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag = 100 + i;
        CGFloat x = ITEM_DISTANCE_SIZE * (i % 4 + 1) + (i % 4) * CHATASSISTANCE_ITEM_SIZE + SCREENWIDTH * (i / 8);
        CGFloat y;
        if (i / 4 % 2 == 0) {
        y = ITEM_DISTANCE_SIZE;
        }else{
        y = CHATASSISTANCE_ITEM_SIZE + 2 * ITEM_DISTANCE_SIZE;
        }
        itemButton.frame = CGRectMake(x, y, CHATASSISTANCE_ITEM_SIZE, CHATASSISTANCE_ITEM_SIZE);
        itemLabel.frame = CGRectMake(x, y + CHATASSISTANCE_ITEM_SIZE, CHATASSISTANCE_ITEM_SIZE, 20);
        [itemButton setImage:[UIImage imageNamed:[[assistanceItemArray objectAtIndex:i] iconButtonBcakImage]] forState:UIControlStateNormal];

        itemLabel.text = [[assistanceItemArray objectAtIndex:i] iconTitle];
        itemLabel.font = BOLDFont_SIZE_13;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.textColor = COLOR_GRAY_DEFAULT_133;
        [chatAssistanceScrollView addSubview:itemButton];
        [chatAssistanceScrollView addSubview:itemLabel];
    }
    assistancePageControl = [[GrayPageControl alloc] initWithFrame:CGRectMake(130, 190, 100, 20)];
    [assistancePageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    assistancePageControl.numberOfPages = assistanceItemArray.count / CHATASSISTANCE_COUNT_PAGE + 1;
    assistancePageControl.currentPage = 0;
    [self addSubview:assistancePageControl];
    [self addSubview:chatAssistanceScrollView];
    
}

#pragma mark SCrollViewDelagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [assistancePageControl setCurrentPage:(chatAssistanceScrollView.contentOffset.x / SCREENWIDTH)];
    [assistancePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {
    [chatAssistanceScrollView setContentOffset:CGPointMake(assistancePageControl.currentPage * SCREENWIDTH, 0) animated:YES];
    [assistancePageControl setCurrentPage:assistancePageControl.currentPage];
}

#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController*)picker didFinishPickingAssets:(NSArray*)assets
{
    
    if ([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        ALAsset* asset = (ALAsset*)[assets objectAtIndex:0];
        UIImage * publishImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.delegate selectResult:publishImg];
        
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
    [_currentVc presentViewController:alertVc animated:YES completion:nil];
    
}

- (void)itemButton:(UIButton *)sender {
 
    switch (sender.tag) {
        case 100:
            
             //打开相册资源
            [self initPickerVc:0 andPhotoNum:1];
            break;
            
        case 101:
            
             //打开视频资源
            [self initPickerVc:1 andPhotoNum:0];
            break;
            
        default:
            break;
    }
}

- (void)initPickerVc:(NSInteger)videoNum andPhotoNum:(NSInteger)photoNum{
    
    _picker = [[UzysAssetsPickerController alloc] init];
    _picker.maximumNumberOfSelectionVideo = videoNum;
    _picker.maximumNumberOfSelectionPhoto = photoNum;
    _picker.delegate = self;
    
    [_currentVc presentViewController:_picker
                             animated:YES
                           completion:^{
                               
                               
                           }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
