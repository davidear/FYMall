//
//  FYNetwork.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYNetwork.h"
#import "FYtool.h"
//


@implementation FYNetwork
{
    AFNetworkReachabilityManager *_reachabilityManager;
    AFNetworkReachabilityStatus _netStatus;
}
single_implementation(FYNetwork)
- (instancetype)init
{
    self = [super init];
    if (self) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kFYNetworkBaseURLStr] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager = manager;

        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_reachabilityManager startMonitoring];
//        __weak typeof(FYNetwork *) blockNetwork = self;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _netStatus = status;
            switch (status) {
                case 0:
                    [FYtool showMsg:@"当前无网络"];
                    break;
                default:
                    break;
            }
        }];
    }
    return self;
}

+ (void)startEngine
{
    [FYNetwork sharedFYNetwork];
}
- (void)HttpGet:(NSString *)URLString parameter:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [_sessionManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (void)HttpPost:(NSString *)URLString parameter:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [_sessionManager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
#pragma mark -
/*!
 @abstract 评论
 @discussion nil 
 
 
@{@"content" : @"特殊一条",
 @"parentid" : @"",
 @"shopid" : @"1",
 @"userid" : @"",
 @"username" : @""
 }
 ShopComment[content]	评论内容 如果是子评论,请附带父评论内容在后面并 @父作者
 
 ShopComment[parentid]	评论父id
 ShopComment[shopid]	商户id
 ShopComment[userid]	当前评论者
 ShopComment[username]	当前评论者的当时名称
 @param dic
 
 @returns nil
 */

- (void)HttpPostComment:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    
    [self HttpPost:[kFYNetworkBaseURLStr stringByAppendingPathComponent:@"index.php?r=shop/shopcomment"] parameter:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/*!
 @abstract get 商店信息
 @discussion index.php?r=shop/select&shopid=商家id&web=0
 @param dic
 @"shopid" : @""
 @returns nil
 */
- (void)HttpGetDinner:(NSDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSString *str = [NSString stringWithFormat:@"index.php?r=shop/select&shopid=%@&web=0",dic[@"shopid"]];
    [self HttpGet:[kFYNetworkBaseURLStr stringByAppendingPathComponent:str] parameter:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
