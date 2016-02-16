//
//  EditController.h
//  Diary
//
//  Created by 我 on 15/11/23.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UITextField *editText;
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;
- (IBAction)onCleanBtn:(UIButton *)sender;

@end
