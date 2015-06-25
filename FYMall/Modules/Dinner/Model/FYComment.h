//
//  FYComment.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/12.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYComment : NSObject
@property (nonatomic, readonly, copy) NSString *userid;
@property (nonatomic, readonly, copy) NSString *commentId;

@property (nonatomic, readonly, copy) NSString *avatar;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *detail;
@property (nonatomic, readonly, copy) NSString *createdAt;
@property (nonatomic, readonly, assign) int likeCount;
- (id)initWithDic:(NSDictionary *)dic;
@end
