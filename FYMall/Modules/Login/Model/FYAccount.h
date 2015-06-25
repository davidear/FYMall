//
//  FYAccount.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/11.
//  readonlyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYAccount : NSObject <NSCoding>
@property (strong, nonatomic) NSString *token;      //dfy 这里？

@property (readonly, nonatomic) NSString *username;
@property (readonly, nonatomic) NSString *password;

@property (readonly, nonatomic) NSString *userid;
@property (readonly, nonatomic) NSString *avatar;      
@property (readonly, nonatomic) NSString *phone;

- (id)initWithDic:(NSDictionary *)dic;
@end
//age = "<null>";
//"bluetooth_key" = "B3B0835B-F2D8-4A0A-AE71-E778454A";
//city = "<null>";
//country = "<null>";
//created = "2015-05-12 03:12:59";
//deviceToken = "";
//district = "<null>";
//email = "<null>";
//"is_payment" = 0;
//lasttime = "<null>";
//"map_latitude" = "108.23";
//"map_longitude" = "23.12";
//modified = "2015-05-12 21:12:59";
//msgmode = 0;
//otherchart = "<null>";
//password = 438e56d6a0eaab518a7b43148b89ba8c;
//phone = 18974968512;
//"phone_info" = "<null>";
//"phone_os" = "8.3";
//preference = "<null>";
//province = "<null>";
//"pwd_answer" = "<null>";
//"pwd_question" = "<null>";
//qq = "<null>";
//remark = "<null>";
//sex = 1;
//"user_avatar" = "<null>";
//"user_config" = "<null>";
//"user_desc" = "<null>";
//userid = 5551fc5b8c35e;
//username = "\U672a\U77e5\U7528\U6237";
//userstatus = 2;
//wechart = "<null>";
//weibo = "<null>";