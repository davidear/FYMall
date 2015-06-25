//
//  FYUserPhoneReset2VC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/22.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYUserPhoneReset2VC.h"
#import "FYLineTextField.h"
#import "FYRoundRectButton.h"
#import "FYtool.h"
#define kCountTime 30
@interface FYUserPhoneReset2VC ()<UITextFieldDelegate>

@end

@implementation FYUserPhoneReset2VC
{
    __weak IBOutlet FYLineTextField *_phoneField;
    __weak IBOutlet FYLineTextField *_verifyCodeField;
    __weak IBOutlet FYRoundRectButton *_okButton;
    __weak IBOutlet FYRoundRectButton *_sendCodeButton;
    
    int _count;
    NSTimer *_countTimer;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    UIBarButtonItem *item = [UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:<#(id)#> action:<#(SEL)#>
//    UINavigationItem *item = [self.navigationController.navigationBar.items objectAtIndex:0];
//    UINavigationItem *back = [[UINavigationItem alloc] initWithTitle:@"Pop"];
//    NSArray *items = [[NSArray alloc] initWithObjects:back,item,nil];
//    [self.navigationController.navigationBar setItems:items];
    [_phoneField becomeFirstResponder];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = item;
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
    
}

- (void)back:(id)sender
{
    //往回跳2个页面
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
}

#pragma mark - TextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
        if (range.location + string.length <= 11) {
            return YES;
        }
    }else {
        if (range.location + string.length <= 6) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - textField Notification
/*
 <FYLineTextField: 0x7fb53dd9be60; baseClass = UITextField; frame = (35 30; 305 21); text = '1'; clipsToBounds = YES; opaque = NO; autoresize = RM+BM; tag = 1; gestureRecognizers = <NSArray: 0x7fb53ddaab30>; layer = <CALayer: 0x7fb53dd9c120>>}
 */
- (void)textFieldDidChanged:(NSNotification *)aNotification
{
    _okButton.enabled = NO;
    _sendCodeButton.enabled = NO;
    if (_phoneField.text.length == 11) {
        if ([FYtool validateMobile:_phoneField.text]) {
            _sendCodeButton.enabled = YES;
            if (_verifyCodeField.text.length == 6) {
                _okButton.enabled = YES;
            }
        }
//        if ([FYtool validateMobile:_phoneField.text] & (_verifyCodeField.text.length == 6)) {
//            _okButton.enabled = YES;
//        }
    }
}
#pragma mark -
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
@end
