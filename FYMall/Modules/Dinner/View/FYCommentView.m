//
//  FYCommentView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYCommentView.h"
#define ANIMATE_DURATION    0.3f

#define kSheetViewHeight    156
@implementation FYCommentView
{
//    __weak IBOutlet UITextView *_commentTextView;
//    __weak IBOutlet UIView *_sheetView;
    
    UIView *_sheetView;
    CGFloat _keyboardHeight;
    UITextView *_commentTextView;
}
+ (id)commentView
{
//    return [[NSBundle mainBundle] loadNibNamed:@"FYCommentView" owner:nil options:nil][0];
    return [[FYCommentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor blackColor];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    toolbar.translucent = YES;
//    toolbar.backgroundColor = [UIColor redColor];
    [toolbar setTintColor:[UIColor blueberryColor]];
//    [self.layer insertSublayer:toolbar.layer above:self.layer];
    [self.layer insertSublayer:[toolbar layer] atIndex:0];

    self.alpha = 0;
    
    CGRect rect = self.bounds;
    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - kSheetViewHeight, rect.size.width, kSheetViewHeight)];
    _sheetView.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:_sheetView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, 10, 50, 30);
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton addTarget:self action:@selector(cancelComment:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:cancelButton];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(_sheetView.bounds.size.width - 50 - 10, 10, 50, 30);
    commentButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [commentButton setTitle:@"发送" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:commentButton];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"写评论";
    label.frame = CGRectMake((_sheetView.bounds.size.width - 30) / 2, 10, 50, 30);
    label.font = [UIFont systemFontOfSize:14];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_sheetView addSubview:label];
    
    _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, _sheetView.bounds.size.height - 10 - 100, rect.size.width - 10 * 2, 100)];
    _commentTextView.text = nil;
    [_sheetView addSubview:_commentTextView];
}

- (void)showWithCommentTo:(NSString *)oldComment shopid:(NSString *)shopid success:(SuccessBlock)success
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.success = success;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:_sheetView];
    [_commentTextView becomeFirstResponder];
}

- (IBAction)cancelComment:(id)sender {
    [_sheetView endEditing:YES];
}
- (IBAction)comment:(id)sender {
    //发送请求
    _success();
    //
    [_sheetView endEditing:YES];
}

- (void)dismissCommentView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
    [_sheetView removeFromSuperview];
}
#pragma mark -
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSLog(@"%@", aNotification);
    _keyboardHeight = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval animationDuration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 0.8;
        _sheetView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _sheetView.bounds.size.height - _keyboardHeight, _sheetView.bounds.size.width, 156);
        
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.alpha = 0;
        _sheetView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _sheetView.bounds.size.width, 156);
    } completion:^(BOOL finished){
        [self dismissCommentView];
    }];
}
@end
