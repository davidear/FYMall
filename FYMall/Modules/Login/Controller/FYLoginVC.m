//
//  FYLoginVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/4/21.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYLoginVC.h"
#import "ToggleView.h"
#import "LXActionSheet.h"
#import "FYTempLoginView.h"
#import "FYRoundRectTextField.h"
#import "FYVerifyView.h"
#import "FYtool.h"
#import "UIImage+FY.h"
#import "FYAccountTool.h"
#import "FYLineUpView.h"

@interface FYLoginVC ()<ToggleViewDelegate,LXActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *registerView;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet FYRoundRectTextField *userNameLoginTextField;
@property (weak, nonatomic) IBOutlet FYRoundRectTextField *passwordLoginTextField;
@property (weak, nonatomic) IBOutlet FYRoundRectTextField *userNameRegisterTextField;
@property (weak, nonatomic) IBOutlet FYRoundRectTextField *passwordRegisterTextField;
@end

@implementation FYLoginVC
{
    ToggleView *_toggle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupLoginUI];
}

//设置UI
- (void)setupLoginUI
{
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"use_img"]];
    imageView1.contentMode = UIViewContentModeCenter;
    imageView1.frame = CGRectMake(0, 0, 20, 30);
    _userNameLoginTextField.leftView = imageView1;
    _userNameLoginTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pasw_img"]];
    imageView2.contentMode = UIViewContentModeCenter;
    imageView2.frame = CGRectMake(0, 0, 20, 30);
    _passwordLoginTextField.leftView = imageView2;
    _passwordLoginTextField.leftViewMode = UITextFieldViewModeAlways;
}
- (void)setupRegisterUI
{
    _userNameRegisterTextField.leftView = _userNameLoginTextField.leftView;
    _userNameRegisterTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordRegisterTextField.leftView = _passwordLoginTextField.leftView;
    _passwordRegisterTextField.leftViewMode = UITextFieldViewModeAlways;
    
    if (_toggle == nil) {
        //头像切换开关
        //ToggleView该插件需要优化重构
        ToggleView *toggle = [[ToggleView alloc] initWithFrame:CGRectMake(0, 0, 138, 74) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeDefault toggleButtonType:ToggleButtonTypeChangeImage];
        toggle.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 71 + 44);
        toggle.toggleDelegate = self;
        [_registerView addSubview:toggle];
        
        //设初值
        [toggle setSelectedButton:ToggleButtonSelectedLeft];
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 按钮事件
- (IBAction)login:(id)sender {
    NSLog(@"start login");
    if (_userNameLoginTextField.text.length != 0 &_passwordLoginTextField.text.length != 0) {
//         [[HTTPSessionManager sharedInstance] userLoginWithPhone:_userNameLoginTextField.text password:_passwordLoginTextField.text rememberMe:@"1" success:^(NSURLSessionDataTask *task, id responseObject) {
//             NSLog(@"%@",responseObject);
////             NSLog(@"login success");
//             if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                 NSDictionary *dic;
//                 if ([[responseObject objectForKey:@"set"] boolValue] == NO) {
//                     [FYtool showMsg:@"登陆失败"];
//                     dic = @{@"oldStatus" : @(Connecting), @"newStatus" : @(Disconnected)};
//                 }else {
//                     [FYtool showMsg:@"登陆成功"];
//                     dic = @{@"oldStatus" : @(Connecting), @"newStatus" : @(Connected), @"token" : [responseObject objectForKey:@"token"], @"userid" : [responseObject objectForKey:@"userid"]};
//                }
//                 [[NSNotificationCenter defaultCenter] postNotificationName:kFYLoginStatusChangedNotification object:self userInfo:dic];
//             }
//         } failure:^(NSURLSessionDataTask *task, NSError *error) {
//             NSLog(@"login error: %@",[error localizedDescription]);
//             [[NSNotificationCenter defaultCenter] postNotificationName:kFYLoginStatusChangedNotification object:self userInfo:@{@"oldStatus" : @(Connecting), @"newStatus" : @(Disconnected)}];
//         }];
    }
}


- (IBAction)signUp:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"start register");
    /*
     逻辑：
     1， 点击登录，调用网络请求发送手机号码去服务器验证
     2， 若验证成功
        2.1  弹出验证短信视图
     补充：若注册成功，再调用登陆接口   //dfy
     */
    
    if (_userNameRegisterTextField.text.length != 0 &_passwordRegisterTextField.text.length != 0) {
//        [[HTTPSessionManager sharedInstance] checkDuplicatePhoneWithPhone:_userNameRegisterTextField.text success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([[responseObject objectForKey:@"phone"] intValue] == 1) {
//                //2.1  弹出验证短信视图
//                FYVerifyView *verifyView = [[FYVerifyView alloc] init];
//                [verifyView showInView:self.view phone:_userNameRegisterTextField.text success:^{
//                    //        int sex = _toggle.selectedButton == ToggleButtonSelectedLeft ? 1 : 0;       //1 表示男性
//                    [[HTTPSessionManager sharedInstance] userSignUpWithPhone:_userNameRegisterTextField.text password:_passwordRegisterTextField.text sex:_toggle.selectedButton == ToggleButtonSelectedLeft ? @"1" : @"0" success:^(NSURLSessionDataTask *task, id responseObject) {
//                        NSLog(@"userSignUpWithPhone success with responseObject : %@", responseObject);
//                        if ([[responseObject objectForKey:@"set"] boolValue] == YES) {
//                            [FYtool showMsg:@"注册成功"];
//                            [self back:nil];
//                            //再登陆
//                            [[FYLoginManager sharedFYLoginManager] manualLogin:@{@"phone" : _userNameRegisterTextField.text, @"password" : _passwordRegisterTextField.text} object:nil];
//                            //再登陆
//                        }else {
//                            [FYtool showMsg:@"注册失败"];
//                        }
//                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                        NSLog(@"error");
//                        [FYtool showMsg:@"注册失败"];
//                    }];
//                }];
//            } else [FYtool showMsg:@"该号码已注册"];
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            [FYtool showMsg:@"网络故障"];
//        }];
    }
}

- (IBAction)switchView:(id)sender {
    if (self.view == _loginView) {
        if (_registerView == nil) {
            _registerView = [[NSBundle mainBundle] loadNibNamed:@"FYRegisterView" owner:self options:nil][0];
            [self setupRegisterUI];
        }
        self.view = _registerView;
        //清数据
        _userNameRegisterTextField.text = nil;
        _passwordRegisterTextField.text = nil;
    }else {
        self.view = _loginView;
        //清数据
        _userNameLoginTextField.text = nil;
        _passwordLoginTextField.text = nil;
    }
}

- (IBAction)forgetPassword:(id)sender {
    LXActionSheet *actionSheet = [[LXActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"临时授权登陆" otherButtonTitles:@[@"密保找回",@"短信验证找回"]];
    [actionSheet showInView:self.view];
}
#pragma mark - 点击空白取消编辑状态
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - ToggleViewDelegate
- (void)selectLeftButton
{
    NSLog(@"Toggle LeftButton Selected");
}

- (void)selectRightButton
{
    NSLog(@"Toggle RightButton Selected");
}

#pragma mark - LXActionSheet Delegate
- (void)didClickOnButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            FYTempLoginView *tempLoginView = [[FYTempLoginView alloc] init];
            [tempLoginView showInView:self.view AvatarBlock:^(UIImagePickerControllerSourceType sourceType){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = sourceType;
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }];
        }
            break;
        case 1:

            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    
}


@end
