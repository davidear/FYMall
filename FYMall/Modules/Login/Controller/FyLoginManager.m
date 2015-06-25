//
//  FYLoginManager.m
//  FYMall
//
//  Created by dai.fengyi on 15/4/21.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYLoginManager.h"
#import "FYLoginVC.h"
#import "KeychainItemWrapper.h"

#import "FYSettingHeaderVC.h"
#import "FYNewFeatureController.h"
#import "FYLineUpView.h"
#import "FYDinnerVC.h"
#import "RESideMenu.h"
#import "FYMainVC.h"
#import "FYLeftMenuVC.h"
#import "FYNavigationController.h"
#import "FYSearchMapVC.h"
#import "FYDinnerCommentVC.h"
#import "FYStorage.h"
#import "FYAccountTool.h"
#import "FYtool.h"
#import "UIImage+FY.h"
//网络



#define kLeftMenuProportion                 0.75
@implementation FYLoginManager 
{
    NSString *_username;
    NSString *_password;
}

single_implementation(FYLoginManager)

- (id)init
{
    self = [super init];
    if (self) {
        [self addNotificationObservers];
    }
    return self;
}

- (void)dealloc
{
    [self removeNotificationObservers];
}

#pragma mark - 通知注册与注销
- (void)addNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChangeNotify:) name:kFYLoginStatusChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFeatureDoneNotify:) name:kFYFeatureDoneNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowLoginNotify:) name:kFYShowLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onFetchAccountInfo:) name:kFYFetchAccountInfoNotification object:nil];
}

- (void)removeNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 登陆动作
- (void)appStart
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageResizedWithName:@"2*2PX橙色点"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    if ([FYStorage isNewVersion]) {
        self.window.rootViewController = [[FYNewFeatureController alloc] init];
    } else {
        if ([FYAccountTool sharedFYAccountTool].account)  [self autologin];
        [self showResideMenu];
    }
}

//- (void)login
//{
//
//        [self clearToken];       //dfy
//        
////        [self TCPlogin];
////        [self showLoginView];
////        [self showSettingVC];
////        [self showDinnerVC];
////        [self showResideMenu];
////        [self showSearchMap];
////        [self showDinnerCommentVC];
//        [self appStart];
////        [self networkTest];
//}
//
//- (void)clearToken
//{
//    [FYAccountTool sharedFYAccountTool].account.token = nil;
//}
- (void)showResideMenu
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    FYMainVC *mainVC = [[FYMainVC alloc] init];
    FYNavigationController *naviVC = [[FYNavigationController alloc] initWithRootViewController:mainVC];
    FYLeftMenuVC *leftVC = [[FYLeftMenuVC alloc] init];
    RESideMenu *menu = [[RESideMenu alloc] initWithContentViewController:naviVC leftMenuViewController:leftVC rightMenuViewController:nil];
    menu.contentViewScaleValue = 1;
//    menu.parallaxEnabled = NO;
//    menu.parallaxEnabled = NO;
//    menu.bouncesHorizontally = NO;
//    menu.contentViewInLandscapeOffsetCenterX = 100;
//    menu.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width / 2;
    menu.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width * (kLeftMenuProportion -0.5);
//    menu.bouncesHorizontally = NO;
    
    [self.window setRootViewController:menu];
}

- (void)showLoginView
{
    FYLoginVC *loginVC = [[FYLoginVC alloc] init];
//    NSArray *arr = [UIApplication sharedApplication].windows;
//    UIWindow *window2 = [UIApplication sharedApplication].keyWindow;
//    UIWindow *window3 = self.window;
//    NSLog(@"\n[UIApplication sharedApplication].windows is %@\n\n[UIApplication sharedApplication].keyWindow is %@\n\nself.window is %@", arr, window2, window3);
    [self.window setRootViewController:loginVC];
}

#pragma mark - dfy
- (void)login:(NSString *)phone password:(NSString *)password object:(id)object
{
//    [[HTTPSessionManager sharedInstance] userLoginWithPhone:phone password:password rememberMe:@"1" success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            if ([[responseObject objectForKey:@"set"] boolValue] == YES) {
//                NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
//                [mutableDic removeObjectForKey:@"set"];
//                [mutableDic setObject:[NSNumber numberWithInt:Connecting] forKey:@"oldStatus"];
//                [mutableDic setObject:[NSNumber numberWithInt:Connected] forKey:@"newStatus"];
//                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:mutableDic];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:kFYLoginStatusChangedNotification object:object userInfo:dic];
//            }
//        }
//    } failure:^(NSURLSessionDataTask * task, NSError * error) {
//        
//    }];
}
- (void)autologin
{
    FYAccount *account = [FYAccountTool sharedFYAccountTool].account;
    [self login:account.phone password:account.password object:nil];
}

- (void)manualLogin:(NSDictionary *)dic object:(id)object
{
    [self login:dic[@"phone"] password:dic[@"password"] object:object];
}


#pragma mark - 通知响应动作
- (void)loginStatusChangeNotify:(NSNotification *)aNotification
{
    [FYAccountTool sharedFYAccountTool].account.token = aNotification.userInfo[@"token"];
    
    AccountStatus oldStatus = (AccountStatus)[[aNotification.userInfo objectForKey:@"oldStatus"] intValue];
    AccountStatus newStatus = (AccountStatus)[[aNotification.userInfo objectForKey:@"newStatus"] intValue];
    if (oldStatus == Connecting & newStatus == Connected) {         //dfy
        [[NSNotificationCenter defaultCenter] postNotificationName:kFYFetchAccountInfoNotification object:nil userInfo:aNotification.userInfo];
        if ([aNotification.object isKindOfClass:[UIViewController class]]) {
            [aNotification.object dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
    }
}

- (void)onFetchAccountInfo:(NSNotification *)aNotification
{
    NSString *userid = aNotification.userInfo == nil ? [FYAccountTool sharedFYAccountTool].account.userid : aNotification.userInfo[@"userid"];
    NSString *token = aNotification.userInfo == nil ? [FYAccountTool sharedFYAccountTool].account.token : aNotification.userInfo[@"token"];
    /*
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
     
     @property (readonly, nonatomic) NSString *username;
     @property (readonly, nonatomic) NSString *password;
     
     @property (readonly, nonatomic) NSString *userid;
     @property (readonly, nonatomic) NSString *avatar;
     @property (readonly, nonatomic) NSString *phone;
     */
    
    [[FYAccountTool sharedFYAccountTool] saveAccount:[[FYAccount alloc] initWithDic:@{@"username" : @"纵横四海", @"userid" : @"5551fc5b8c35e", @"user_avatar" : [NSNull null], @"password" : @"438e56d6a0eaab518a7b43148b89ba8c", @"phone" : @"18974968512"}]];
    [FYAccountTool sharedFYAccountTool].account.token = token;             //dfy
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:kFYAccountInfoNotification object:nil];
    
//    [[HTTPSessionManager sharedInstance] getUserInfoWithUserID:userid token:token success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"visitorSignUpWithSuccess success with responseObject : %@", responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            [[FYAccountTool sharedFYAccountTool] saveAccount:[[FYAccount alloc] initWithDic:responseObject]];
//            [FYAccountTool sharedFYAccountTool].account.token = token;             //dfy
//            //
//            [[NSNotificationCenter defaultCenter] postNotificationName:kFYAccountInfoNotification object:nil];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"fetchAccountInfo failed, error is %@", [error localizedDescription]);
//    }];

}

- (void)onFeatureDoneNotify:(NSNotification *)aNotification
{
    [self appStart];
}

- (void)onShowLoginNotify:(NSNotification *)aNotification
{
    NSLog(@"aNotification is %@", aNotification);
    if ([aNotification.object isKindOfClass:[UIViewController class]]) {
        FYLoginVC *vc = [[FYLoginVC alloc] init];
        [aNotification.object presentViewController:vc animated:YES completion:^{
        }];
    }
}
@end
