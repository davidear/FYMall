//
//  FYConstant.h
//  FYMall
//
//  Created by dai.fengyi on 15/4/22.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#ifndef FYMall_FYConstant_h
#define FYMall_FYConstant_h


//// 颜色RBG值 ZKJSColor(rgbValue),例ZKJSColor(0xFF10EE)
//#define ZKJSColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//打印界面日志开关    1-开，0-关
#define UI_DEBUG 1
#if UI_DEBUG
#define ZKJS_UI_NSLog(format,...){   \
NSDateFormatter* formatter = [[NSDateFormatter alloc]init];\
[formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
NSString* date = [formatter stringFromDate:[NSDate date]];\
NSString * printLog=nil;\
printLog=[NSString stringWithFormat:@"[ZKJS] [%@] [UILog] [LINE:%d %s] [%@]",date,__LINE__,__FUNCTION__,[NSString stringWithFormat:format,##__VA_ARGS__]];\
const char* contentChars = [printLog cStringUsingEncoding:NSUTF8StringEncoding];\
printf("%s\n", contentChars);\
}
#else
#define ZKJS_UI_NSLog(format,...){   \
}
#endif

//打印SDK日志开关  1-开，0-关
#define SDK_DEBUG 1
#if SDK_DEBUG
#define ZKJS_SDK_NSLog(format,...){   \
NSDateFormatter* formatter = [[NSDateFormatter alloc]init];\
[formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
NSString* date = [formatter stringFromDate:[NSDate date]];\
NSString * printLog=nil;\
printLog=[NSString stringWithFormat:@"[ZKJS] [%@] [SDKLog] [LINE:%d %s] [%@]",date,__LINE__,__FUNCTION__,[NSString stringWithFormat:format,##__VA_ARGS__]];\
const char* contentChars = [printLog cStringUsingEncoding:NSUTF8StringEncoding];\
printf("%s\n", contentChars);\
}
#else
#define ZKJS_SDK_NSLog(format,...){   \
}
#endif


// 基础常量
#define ZKJSBlueColor ZKJSColor(0x0B60FE)                                       // 全局蓝色
#define ZKFYrayColor(value) [UIColor colorWithWhite:value alpha:1]           // 白色灰度
#define ZKJSFont15 [UIFont systemFontOfSize:15]                               // 15号字体
#define ZKJSImage(imageName) [UIImage imageNamed:imageName]                   // 加载图片
#define ZKJSIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]  // ios版本
#define ZKJSApp [UIApplication sharedApplication]                             // 当前App
#define ZKJSNotice [NSNotificationCenter defaultCenter]                       // 通知中心
#define ZKJSPrefe [NSUserDefaults standardUserDefaults]                       // 偏好设置
#define ZKJSScreenSize [UIScreen mainScreen].bounds.size                      // 屏幕尺寸
#define ZKJSMainBundle [NSBundle mainBundle]                                  // MainBundle
#define ZKJSColorWithImage(imageName) [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
#define ZKJSBlockSelf __weak typeof(self)



//UI颜色
//LoginVC
#define FYLoginVCTextFieldColor                          @"0xdcdcdc"
#define FYLoginVCLoginButtonColorForNormal               @"0xfd8800"
#define FYLoginVCLoginButtonColorForHighlight            @"0x985200"
#define FYLoginVCRegisterButtonColorForNormal            @"0x33c5b7"
#define FYLoginVCRegisterButtonColorForHighlight         @"0x1f776e"
#define FYLoginVCButtonTextColorForNormal                       @"0x000000"
//#define FYLoginVCButtonTextColorForHighlight             @"0x000000"

// 扩展分类
//#import "UIBarButtonItem+ZKJS.h"
//#import "UIImage+ZKJS.h"
//#import "UIButton+ZKJS.h"
//#import "UIView+ZKJS.h"
//#import "UIImageView+ZKJS.h"
//#import "UIViewController+ZKJS.h"
//#import "NSDictionary+ZKJS.h"
//#import "NSMutableDictionary+ZKJS.h"
//#import "NSString+ZKJS.h"
//#import "UITableView+ZKJS.h"

// 存储键值
//#define kZKJSUserName                     @"ZKJSUserName"                   // 用户名
//#define kZKJSPassword                     @"ZKJSPassword"                   // 密码
//#define kZKJSUserID                       @"ZKJSUserID"                     // 用户ID
//#define kZKJSUserToken                    @"ZKJSUserToken"                  // Token
//#define kZKJSTimeStamp                    @"ZKJSTimeStamp"                  // timeStamp
//#define kZKJSScreenLockKey                @"ZKJSScreenLockKey"              // 解锁密码
//#define kZKJSRemeberPassWord              @"ZKJSRemeberPassWord"            // 记住密码
//#define kZKJSNeedScreenLock               @"ZKJSNeedScreenLock"             // 需要解锁
//#define kZKJSForgetPassword               @"ZKJSForgetPassword"             // 忘记密码
//#define kZKJSLocationAddress              @"ZKJSLocationAddress"            // 当前地址
//#define kZKJSUserLocation                 @"ZKJSUserLocation"               // 用户经纬度
//#define kZKJSLocationFlag                 @"ZKJSLocationFlag"               // 定位标记
//#define kZKJSImageUploadQueue             @"ZKJSImageUploadQueue"           // 图片上传
//#define kZKJSDownloadBaseWiFi             @"ZKJSDownloadBaseWiFi"           // WiFi模式显示图片
//#define kZKJSCleanCachesWhenExit          @"ZKJSCleanCachesWhenExit"        // 退出系统时清空缓存

// 通知名称
//#define kZKFYetLocationSuccess           @"ZKFYegLocationSuccess"         // 定位成功
//#define kZKFYetLocationError             @"ZKFYetLocationError"           // 定位失败
//#define kZKFYetAddressSuccess            @"ZKFYetAddressSuccess"          // 反地址编码成功
//#define kZKJSFindPasswordSuccess          @"ZKJSFindPasswordSuccess"        // 成功找回密码
//#define kZKJSTerminalAddPickViewDone      @"ZKJSTerminalAddPickViewDone"    // PickView完成
//#define kZKJSCompleteAllShopSyn           @"ZKJSCompleteAllShopSyn"         // 所有店铺同步完成
//#define kZKJSCompleteShopPlanSyn          @"ZKJSCompleteShopPlanSyn"        // 今日计划同步完成
//#define kZKJSConsumerUpdate               @"ZKJSConsumerUpdate"             // 消费者信息更新

//#define kFYLoginSuccessNotification         @"kFYLoginSuccessNotification"
//#define kFYLogoutSuccessNotification        @"kFYLogoutSuccessNotification"
//#define kFYLoginFailureNotification         @"kFYLoginFailureNotification"
#define kFYLoginStatusChangedNotification      @"kFYLoginStatusChangedNotification"
#define kFYFeatureDoneNotification             @"kFYFeatureDoneNotification"
#define kFYAccountInfoNotification             @"kFYAccountInfoNotification"

#define kFYShowLoginNotification               @"kFYShowLoginNotification"
#define kFYFetchAccountInfoNotification        @"kFYFetchAccountInfoNotification"

#define kFYDidEnterBeaconRegion                @"ZKJSDidEnterBeaconRegion"
#define kFYDidAutoQueue                        @"ZKJSDidAutoQueue"
typedef enum Status
{
    Disconnected,
    Connected,
    Connecting,
    Disconnecting
}AccountStatus;
;
// 网络接口
#define kFYNetworkBaseURLStr               @"http://120.25.241.196"
#define kFYNetworkAvatarURLStr(A)          [NSString stringWithFormat:@"http://120.25.241.196/uploads/users/%@.jpg",A]

#endif
