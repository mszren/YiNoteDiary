//
//  PublishController.h
//  Diary
//
//  Created by 我 on 15/11/13.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysAssetsPickerController.h"

@interface PublishController : UIViewController <MessageRoutable>
@property (nonatomic, strong)NSMutableArray *assets;
@property (nonatomic, strong)NSString *assetName;
@property (nonatomic,strong)UzysAssetsPickerController* picker;

@end
