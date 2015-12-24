//
//  Message.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "Message.h"

@implementation Message

- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.icon = dict[@"icon"];
    self.time = dict[@"time"];
    self.content = dict[@"content"];
    self.contentImg = dict[@"contentImg"];
    self.locationDic = dict[@"locationDic"];
    self.type = [dict[@"type"] intValue];
    self.contentType = [dict[@"contentType"] intValue];
    self.contentTime = [dict[@"contentTime"] intValue];
}



@end
