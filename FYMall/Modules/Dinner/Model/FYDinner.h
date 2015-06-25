//
//  FYDinner.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/12.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYDinner : NSObject
@property (nonatomic, copy, readonly) NSString *shopid;
@property (nonatomic, copy, readonly) NSString *fullname;
@property (nonatomic, copy, readonly) NSString *logo;
@property (nonatomic, copy, readonly) NSString *introducce;
@property (nonatomic, copy, readonly) NSString *recommend;
@property (nonatomic, copy) NSString *distance;
- (id)initWithDic:(NSDictionary *)dic;
/*
{
    annualincome = "<null>";
    city = "\U6df1\U5733";
    countrycode = "+86";
    created = "2015-04-01 14:50:00";
    cstsource = "sc-a";
    "curr_code" = RMB;
    email = "yzj@qq.com";
    fax = 075588886658;
    fulladdrs = "\U4eba\U95f4\U4e0e\U5357\U5929\U95e8\U8def\U4e0a";
    fullname = "\U82ad\U82ad\U62c9\U5361UI\U9910\U5385";
    industry = "\U9910\U996e\U884c\U4e1a";
    "is_onlinepay" = 1;
    "known_as" = "\U82ad\U82ad\U62c9";
    location = "CN-zh";
    logo = "uploads/shops/2.jpg";
    "map_latitude" = "<null>";
    "map_longitude" = "<null>";
    others = "<null>";
    phone = 13434400274;
    postcode = 518000;
    province = "\U5e7f\U4e1c";
    "shop_desc" = "<null>";
    "shop_recomm" = "<null>";
    shopcode = "b-0001";
    shopid = 9955613;
    staffnumber = 50;
    status = 0;
    telcode = 0755;
    type = 0;
    url = "http://cc.com";
    wechart = "<null>";
    weibo = "<null>";
    "work_begin" = "2015-05-06 08:50:00";
    "work_end" = "2015-05-31 21:59:59";
}*/
@end
