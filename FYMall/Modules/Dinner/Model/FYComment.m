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
        _commentId = [dic objectForKey:@"commentId"];
        
        _likeCount = [[dic objectForKey:@"likeCount"] intValue];
        _name = [dic objectForKey:@"name"];
        _detail = [dic objectForKey:@"detail"];
//        _avatar = kFYNetworkAvatarURLStr(_userid);
        _avatar = [dic objectForKey:@"avatar"];
        _createdAt = [dic objectForKey:@"createdAt"];
    }
    return self;
}
@end
