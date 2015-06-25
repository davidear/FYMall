//
//  FYStorage.h
//  FYMall
//
//  Created by dai.fengyi on 4/28/15.
//  Copyright (c) 2015 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define FYCache           [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]             //  cache目录
#define FYDocument        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]      //  document目录
#define FYLibrary         [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]            //  library目录
#define FYHome            NSHomeDirectory()                                                                                       //  home目录
#define FYTemporary       NSTemporaryDirectory()                                                                                  //  temp目录


@interface FYStorage : NSObject
single_interface(FYStorage)
+ (NSString *)cacheDirectory;
+ (NSString *)documentDirectory;
+ (NSString *)libraryDirectory;
+ (NSString *)homeDirectory;
+ (NSString *)temporaryDirectory;

+ (NSString *)imageCachesFolder;
+ (NSString *)dataCachesFolder;

//创建并返回目录
+ (NSString *)creatCacheSubFolder:(NSString *)folder;
+ (NSString *)creatDocumentSubFolder:(NSString *)folder;
+ (NSString *)creatFolder:(NSString *)folder path:(NSString *)path;

//读登陆列表
+ (NSArray *)readLoginList;
//写登陆信息进列表（NSUserDefault）
+ (void)saveLoginListWithUsername:(NSString *)username password:(NSString *)password;

+ (BOOL)isNewVersion;
@end