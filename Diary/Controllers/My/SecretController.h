//
//  SecretController.h
//  Diary
//
//  Created by 我 on 15/11/20.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretController : UIViewController <MessageRoutable>
@property (weak, nonatomic) IBOutlet UIView *adressBookBlackView;
@property (weak, nonatomic) IBOutlet UISwitch *hideToAnyoneSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *hideToFriendSwitch;

@property (weak, nonatomic) IBOutlet UIView *noLookMyView;
@property (weak, nonatomic) IBOutlet UIView *noLookOtherView;
@property (weak, nonatomic) IBOutlet UISwitch *allowLookPhotoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *allowLookTrailSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *allowLookSignSwitch;
@property (weak, nonatomic) IBOutlet UIView *signBlackAdressView;
@property (weak, nonatomic) IBOutlet UISwitch *allowLookAdressView;
@property (weak, nonatomic) IBOutlet UIView *areaBlackAdressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
