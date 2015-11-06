//
//  IAnimationHost.h
//  Dolphin
//
//  Created by Jim Huang on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IAnimationHost <NSObject>

-(void)addAnimationView:(UIView*)animationView;
-(void)removeAnimationView:(UIView*)animationView;

@end
