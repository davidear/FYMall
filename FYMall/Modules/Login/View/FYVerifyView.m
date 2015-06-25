//
//
//  FYVerifyView.m
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYVerifyView.h"
#import "FYtool.h"
#define ANIMATE_DURATION   0.3f
@interface FYVerifyView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *sheetView;
@end
@implementation FYVerifyView
{
    NSString *_phone;
}
- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"FYVerifyView" owner:self options:nil] lastObject];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
        [self.sheetView addGestureRecognizer:tap];
        
        self.codeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"use_img"]];
        self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
        
        self.codeTextField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"提示img01"]];
        self.codeTextField.rightViewMode = UITextFieldViewModeAlways;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
        [self addGestureRecognizer:tapGesture];
        
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

- (void)showInView:(UIView *)view phone:(NSString *)phone success:(SuccessBlock)success
{
    self.success = success;
    _phone = phone;
 
    [self requestSmsCodePhone:_phone];
    
    self.sheetView.frame = CGRectMake(0, self.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
//    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    [view addSubview:self];
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.sheetView.frame = CGRectMake(0, self.bounds.size.height - self.sheetView.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)endEditing
{
    [self endEditing:YES];
}

#pragma mark - 按钮事件
- (IBAction)verifyCode:(id)sender {
    if (_codeTextField.text.length != 0) {
        [self verifySmsCode:_codeTextField.text phone:_phone];
    }
    [self endEditing];
}

- (IBAction)resendMSG:(id)sender {
    [self requestSmsCodePhone:_phone];
}
- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.sheetView.frame = CGRectMake(0, self.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

//- (void)cancelEditing:(id)sender {
//    if (self.frame.origin.y == 0) {
//        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
//            self.sheetView.frame = CGRectMake(0, self.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
//            self.alpha = 0;
//        } completion:^(BOOL finished) {
//            if (finished) {
//                [self removeFromSuperview];
//            }
//        }];
//    }else {
//        [self endEditing:YES];
//    }
//}

//#pragma mark - UIAlertView Delegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 1:
//        {
//            self.avatarBlock(UIImagePickerControllerSourceTypeCamera);
//        }
//            break;
//        case 2:
//        {
//            self.avatarBlock(UIImagePickerControllerSourceTypePhotoLibrary);
//        }
//            break;
//        default:
//            break;
//    }
//    [alertView dismissWithClickedButtonIndex:0 animated:YES];
//}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.frame = CGRectOffset(self.bounds, 0, -150);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.frame.origin.y != 0) {
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            self.frame = self.bounds;
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - 网络
- (void)requestSmsCodePhone:(NSString *)phone
{
    // 发送验证码 done
//    [[HTTPSessionManager sharedInstance] requestSmsCodeWithPhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
//        NSLog(succeeded ? @"success" : @"fail");
//        if (!succeeded) {
//            [FYtool showMsg:@"验证码已发送"];
//        }
//    }];
}

- (void)verifySmsCode:(NSString *)code phone:(NSString *)phone
{
    [FYtool showLoading];
    // 检查验证码
//    [[HTTPSessionManager sharedInstance] verifySmsCode:code phone:phone callback:^(BOOL succeeded, NSError *error) {
//        NSLog(succeeded ? @"success" : @"fail");
//        if (!succeeded) {
//            [FYtool hideHUD];
//            [self cancel:nil];
//            self.success();
//        }
//    }];
}

@end