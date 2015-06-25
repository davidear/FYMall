//
//  FYAccountTool.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/11.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYAccountTool.h"
#import "FYStorage.h"
#define kFilePath       [[FYStorage documentDirectory] stringByAppendingPathComponent:@"account.data"]

@implementation FYAccountTool
single_implementation(FYAccountTool)

- (id)init
{
    self = [super init];
    if (self) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _account.token = nil;       //第一次初始化时，清零
    }
    return self;
}

- (void)saveAccount:(FYAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:_account toFile:kFilePath];
}
@end
