//
//  SynTableProtocol.h
//  Diary
//
//  Created by Owen on 15/10/28.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SynTableProtocol <NSObject>
@required

- (NSString *)identifier;

-(BOOL) isDirty;

-(BOOL) isDeleted;


@end
