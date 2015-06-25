//
//  FYDinnerVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/5.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerVC.h"
#import "FYAdvertiseView.h"
#import "UIImage+FY.h"
#import "FYLineUpView.h"
#import "FYDinnerCommentVC.h"
//#import "ZKJSTCPSessionManager.h"
#import "FYAccountTool.h"

#import "FYNetwork.h"
#import "MobClick.h"

#define kCountTime          1
@interface FYDinnerVC ()
@property (weak, nonatomic) IBOutlet FYAdvertiseView *adView;

@end

@implementation FYDinnerVC
{
    NSString *_shopID;
    FYDinner *_dinner;
}
- (id)initWithShopID:(NSString *)shopID
{
    self = [super init];
    if (self) {
        _shopID = shopID;
        [self addEventObserver];
    }
    return self;
}

- (void)addEventObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDidAutoQueue:) name:kFYDidAutoQueue object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    
    self.title = @"餐厅详情";
    
    _adView.imageArray = @[@"baner图1",@"baner图2",@"baner图3",@"baner图4"];
    _adView.autoSlide = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void)loadData
{
//    [[HTTPSessionManager sharedInstance] getShopInfoWithShopID:_shopID success:^(NSURLSessionDataTask * task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            _dinner = [[FYDinner alloc] initWithDic:responseObject[0]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.title = _dinner.fullname;
//            });
//
//        }
//    } failure:^(NSURLSessionDataTask * task, NSError * error) {
//        NSLog(@"%@", error);
//    }];
//    [[FYNetwork sharedFYNetwork] HttpGetDinner:@{@"shopid" : _shopID} success:^(id responseObject) {
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            _dinner = [[FYDinner alloc] initWithDic:responseObject[0]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.title = _dinner.fullname;
//            });
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button Action
- (IBAction)lineUp:(id)sender {
    /*
     type MsgQueRequestGetNo struct {
     Type       uint32 `json:"type"`
     CreateType uint32 `json:"ctype"` //0:手动取号 1：自动取号
     UserID     string `json:"userid"`
     ShopID    string `json:"shopid"` iosShop1
     PeopleNum uint32 `json:"peoplenum"` // 人数
     Timestamp int64  `json:"timestamp"`
     }
     */

    
    [self showLineUpAnimation];
}
- (void)showLineUpAnimation
{
    FYLineUpView *lineUpView = [[FYLineUpView alloc] initWithFrame:self.view.bounds];
    [lineUpView setLineTextWithPeople:0 minutes:0];
    [lineUpView setAnimationWithCircleCount:4 color:[UIColor whiteColor] duration:2.0 seconds:kCountTime];
    [lineUpView showInView:self.view];
    [self performSelector:@selector(dismissAfterDelayWithView:) withObject:lineUpView afterDelay:kCountTime];
}
- (IBAction)callService:(id)sender {
}
- (IBAction)searchAround:(id)sender {
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 暂时处理方式
- (void)dismissAfterDelayWithView:(FYLineUpView *)lineUpView
{
    [lineUpView dismissFromView];
    FYDinnerCommentVC *vc = [[FYDinnerCommentVC alloc] initWithDinner:_dinner];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 响应
- (void)onDidAutoQueue:(NSNotification *)aNotification
{
//    [self showLineUpAnimation];
    [self lineUp:nil];
}
@end