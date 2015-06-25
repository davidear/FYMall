//
//  FYAccount.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/11.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYAccount.h"
//#import "SDWebImageDownloader.h"
//@property (readonly, nonatomic) NSString *username;
//@property (readonly, nonatomic) NSString *password;
//
//@property (readonly, nonatomic) NSString *userid;
//@property (readonly, nonatomic) NSString *user_avatar;
@implementation FYAccount
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _userid = dic[@"userid"];
        _password = dic[@"password"];
        _username = dic[@"username"];
        _phone = dic[@"phone"];
        if (![dic[@"user_avatar"] isKindOfClass:[NSNull class]]) {
            _avatar = [kFYNetworkBaseURLStr stringByAppendingPathComponent:dic[@"user_avatar"]];// dic[@"user_avatar"] 只带后半截，得自己拼接
        }
        //        if (![dic[@"user_avatar"] isKindOfClass:[NSNull class]]) {
//            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[kFYNetworkBaseURLStr stringByAppendingPathComponent:dic[@"user_avatar"]]] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//                if (finished) {
//                    _avatar = image;
//                }
//            }];
//        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_userid forKey:@"userid"];
    [aCoder encodeObject:_avatar forKey:@"avatar"];
    [aCoder encodeObject:_phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _username = [aDecoder decodeObjectForKey:@"username"];
        _password = [aDecoder decodeObjectForKey:@"password"];
        _userid = [aDecoder decodeObjectForKey:@"userid"];
        _avatar = [aDecoder decodeObjectForKey:@"avatar"];
        _phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
