//
//  FYTempLoginView.m
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYTempLoginView.h"
#define ANIMATE_DURATION   0.25f
@interface FYTempLoginView()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *sheetView;
@property (weak, nonatomic) IBOutlet UITextView *anounceTextView;
@end
@implementation FYTempLoginView
- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"FYTempLoginView" owner:self options:nil] lastObject];
    if (self) {
        self.anounceTextView.contentSize = self.anounceTextView.bounds.size;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
        [self.sheetView addGestureRecognizer:tap];

        self.phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"use_img"]];
        self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
        self.phoneTextField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"提示img01"]];
        self.phoneTextField.rightViewMode = UITextFieldViewModeAlways;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
        [self addGestureRecognizer:tapGesture];
        
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

- (void)showInView:(UIView *)view AvatarBlock:(AvatarBlock)avatarBlock
{
    self.avatarBlock = avatarBlock;
    
    self.sheetView.frame = CGRectMake(0, self.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
//    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    [view addSubview:self];
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.sheetView.frame = CGRectMake(0, self.bounds.size.height - self.sheetView.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
            self.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)endEditing
{
    [self endEditing:YES];
}
#pragma mark - 按钮事件
- (IBAction)avatar:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [alertView show];
}
- (IBAction)cancel:(id)sender {
    [self endEditing:YES];
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.sheetView.frame = CGRectMake(0, self.bounds.size.height, self.sheetView.bounds.size.width, self.sheetView.bounds.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            self.avatarBlock(UIImagePickerControllerSourceTypeCamera);
        }
            break;
        case 2:
        {
            self.avatarBlock(UIImagePickerControllerSourceTypePhotoLibrary);
        }
            break;
        default:
            break;
    }
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

@end
