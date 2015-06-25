//
//  FYDinner.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/12.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinner.h"

@implementation FYDinner
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _shopid = [dic objectForKey:@"shopid"];
        _fullname = [dic objectForKey:@"fullname"];
        _logo = [kFYNetworkBaseURLStr stringByAppendingPathComponent:[dic objectForKey:@"logo"]];  //  uploads/shops/shop_m.jpg
        _introducce = @"海鲜特色餐厅，新鲜美味";
        _recommend = @"特色推荐：关东海参";
        _distance = @"直行15米";
    }
    return self;
}
@end
