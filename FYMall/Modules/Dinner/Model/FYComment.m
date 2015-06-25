//
//  FYComment.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/12.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYComment.h"

@implementation FYComment
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _userid = [dic objectForKey:@"userid"];
        _commentId = [dic objectForKey:@"id"];
        
        _likeCount = [[dic objectForKey:@"flag"] intValue];
        _name = [dic objectForKey:@"username"];
        _detail = [dic objectForKey:@"content"];
        _avatar = kFYNetworkAvatarURLStr(_userid);
        _createdAt = [dic objectForKey:@"created"];
    }
    return self;
}
@end
