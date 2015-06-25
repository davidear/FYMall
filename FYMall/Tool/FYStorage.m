//
//  FYStorage.m
//  FYMall
//
//  Created by dai.fengyi on 4/28/15.
//  Copyright (c) 2015 childrenOurFuture. All rights reserved.
//

#import "FYStorage.h"


#define kLoginInfo          @"kLoginInfo"
@implementation FYStorage
single_implementation(FYStorage)
+ (void)initialize
{
    [self creatCacheSubFolder:@"imagesCaches"];
    [self creatCacheSubFolder:@"dataCaches"];
}

+ (NSString *)cacheDirectory
{
    return FYCache;
}
+ (NSString *)documentDirectory
{
    return FYDocument;
}
+ (NSString *)libraryDirectory
{
    return FYLibrary;
}
+ (NSString *)homeDirectory
{
    return FYHome;
}
+ (NSString *)temporaryDirectory
{
    return FYTemporary;
}


+ (NSString *)imageCachesFolder
{
    return [FYCache stringByAppendingPathComponent:@"imageCaches"];
}
+ (NSString *)dataCachesFolder
{
    return [FYCache stringByAppendingPathComponent:@"dataCaches"];
}


+ (NSString *)creatCacheSubFolder:(NSString *)folder
{
    return [self creatFolder:folder path:FYCache];
}

+ (NSString *)creatDocumentSubFolder:(NSString *)folder
{
    return [self creatFolder:folder path:FYDocument];
}
+ (NSString *)creatFolder:(NSString *)folder path:(NSString *)path
{
    //1. 初始化NSFileManager
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    //2. 拼接新目录字符串path/folder
    NSString *newFolder = nil;
    if ([fileManager fileExistsAtPath:path]) {
        newFolder = [path stringByAppendingPathComponent:folder];
    }else {
        NSLog(@"路径path不存在，转存到Caches目录");
        newFolder = [FYCache  stringByAppendingPathComponent:path];
    }
    return newFolder;
}

//字典可加入 rememberPassword:(BOOL)rememberPassword autoLogin:(BOOL)autoLogin两个字段
+ (void)saveLoginListWithUsername:(NSString *)username password:(NSString *)password
{
    NSMutableArray *mutArr = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginInfo];
    if (mutArr == nil) {
        mutArr = [NSMutableArray arrayWithObject:@{@"username" : username, @"password" : password}];
    }else {
        for (NSDictionary *dic in mutArr) {
            //已存在，则更新密码
            if ([[dic objectForKey:@"username"] isEqualToString:username]) {
                [dic setValue:password forKey:@"usernaem"];
                [[NSUserDefaults standardUserDefaults] setObject:mutArr forKey:kLoginInfo];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return;
            }
        }
        [mutArr insertObject:@{username : password} atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:mutArr forKey:kLoginInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSArray *)readLoginList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginInfo];
}

+ (BOOL)isNewVersion
{
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([version isEqualToString:savedVersion]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

@end
