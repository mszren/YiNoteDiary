//
//  AgeController.h
//  Diary
//
//  Created by 我 on 15/11/24.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgeController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end
