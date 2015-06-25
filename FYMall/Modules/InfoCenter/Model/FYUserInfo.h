//
//  FYUserInfo.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/20.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
    userid         varchar(32)   utf8_esperanto_ci  NO      PRI     (NULL)                     select,insert,update,references  用精确到纳秒或uuid来做id,不使用数库自增。
    username       varchar(30)   utf8_esperanto_ci  NO      MUL     (NULL)                     select,insert,update,references  用户名
    password       varchar(300)  utf8_esperanto_ci  NO              (NULL)                     select,insert,update,references  密码
    user_avatar    varchar(100)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  用户头像
    user_desc      varchar(100)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  个性签名
    age            varchar(10)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  年龄
    sex            tinyint(1)    (NULL)             YES             (NULL)                     select,insert,update,references  性别
    userstatus     tinyint(1)    (NULL)             NO              0                          select,insert,update,references  用户状态,0.生效,1失效.
    phone          varchar(30)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  电话号码
    email          varchar(30)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  邮箱
    msgmode        tinyint(1)    (NULL)             YES             0                          select,insert,update,references  消息接收模式:0:震动 1:响铃 2:免打扰 3:震动+响铃
    qq             varchar(30)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  QQ
    wechart        varchar(30)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  微信
    weibo          varchar(30)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  微博
    otherchart     varchar(50)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  其它社交帐号
    is_payment     tinyint(1)    (NULL)             YES             0                          select,insert,update,references  是否已绑定支付方式 0:未绑定 1:绑定
    country        varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  国籍
    province       varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  省份
    city           varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  城市
    district       varchar(150)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  地区
    phone_info     varchar(50)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  设备信息
    map_longitude  varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  经度
    map_latitude   varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  纬度
    phone_os       varchar(20)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  手机os
    user_config    varchar(10)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  参数配置
    deviceToken    varchar(50)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  手机唯一标识
    preference     varchar(500)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  用户喜好
    pwd_question   varchar(200)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  密保问题
    pwd_answer     varchar(150)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  密保问题答案
    remark         varchar(255)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  备注
    created        datetime      (NULL)             YES             (NULL)                     select,insert,update,references  注册时间
    modified       timestamp     (NULL)             YES             CURRENT_TIMESTAMP          select,insert,update,references  最后修改时间
    lasttime       datetime      (NULL)             YES             (NULL)                     select,insert,update,references  最后登录时间
    bluetooth_key  varchar(32)   utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  蓝牙id
    birthday       date          (NULL)             YES             (NULL)                     select,insert,update,references  生日
    tagsid         varchar(640)  utf8_esperanto_ci  YES             (NULL)                     select,insert,update,references  标签
}
*/
@interface FYUserInfo : NSObject

@end
