//
//  FYUserPhoneReset1VC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/21.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYUserPhoneReset1VC.h"
#import "FYRoundRectButton.h"
#import "FYLineTextField.h"
#import "FYtool.h"
#import "FYUserPhoneReset2VC.h"


#define kCountTime 30
@interface FYUserPhoneReset1VC () <UITextFieldDelegate>

@end

@implementation FYUserPhoneReset1VC
{
    __weak IBOutlet FYLineTextField *_phoneField;
    __weak IBOutlet FYLineTextField *_verifyCodeField;
    __weak IBOutlet FYRoundRectButton *_sendCodeButton;
    __weak IBOutlet FYRoundRectButton *_okButton;

    int _count;
    NSTimer *_countTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubview];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getVerifyCode:nil];
}

- (void)setupSubview
{
    [_verifyCodeField becomeFirstResponder];
}

- (IBAction)getVerifyCode:(id)sender {
    [self requestSmsCode];
    _sendCodeButton.enabled = NO;
    _count = kCountTime;
    _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshCount:) userInfo:nil repeats:YES];
}
- (void)refreshCount:(id)sender
{
    [_sendCodeButton setTitle:[NSString stringWithFormat:@"发送验证码(%d)",_count] forState:UIControlStateDisabled];
    if (_count-- == 0) {
        [_countTimer invalidate];
        _sendCodeButton.enabled = YES;
        [_sendCodeButton setTitle:@"发送验证码" forState:UIControlStateDisabled];
    }
}
- (IBAction)okButtonClicked:(id)sender {
    [self verifySmsCode];
}

#pragma mark - TextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location + string.length <= 6) {
        _okButton.enabled = NO;
        if (range.location + string.length == 6) {
            _okButton.enabled = YES;
        }
        return YES;
    }else return NO;
}

- (void)requestSmsCode
{
//    [[HTTPSessionManager manager] requestSmsCodeWithPhoneNumber:_phoneField.text callback:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            [FYtool showMsg:@"验证码已发送"];
//        }
//    }];
}

- (void)verifySmsCode
{
//    [[HTTPSessionManager manager] verifySmsCode:_verifyCodeField.text phone:_phoneField.text callback:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            //跳转
//            FYUserPhoneReset2VC *vc = [[FYUserPhoneReset2VC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }];
    
    FYUserPhoneReset2VC *vc = [[FYUserPhoneReset2VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//- (void)requestSmsCodeWithPhoneNumber:(NSString *)phone callback:(void (^)(BOOL succeeded, NSError *error))callback {
//    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
//        NSLog(succeeded ? @"requestSmsCodeWithPhoneNumber success" : @"requestSmsCodeWithPhoneNumber fail");
//        callback(succeeded, error);
//    }];
//}
//
//- (void)verifySmsCode:(NSString *)code phone:(NSString *)phone callback:(void (^)(BOOL succeeded, NSError *error))callback {
//    [AVOSCloud verifySmsCode:code mobilePhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
//        NSLog(succeeded ? @"verifySmsCode success" : @"verifySmsCode fail");
//        callback(succeeded, error);
//    }];
//    
//}
@end
