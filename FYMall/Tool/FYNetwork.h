//
//  FYNetwork.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Singleton.h"
@interface FYNetwork : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) AFNetworkReachabilityManager *reachabilityManager;
single_interface(FYNetwork)


+ (void)startEngine;
- (void)HttpPostComment:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)HttpGetDinner:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
