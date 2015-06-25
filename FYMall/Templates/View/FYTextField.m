//
//  FYRoundRectTextField.m
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYTextField.h"


@implementation FYTextField
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.clipsToBounds = YES;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    if (_rightButton != nil) {
        _rightButton.frame = CGRectMake(self.bounds.size.width - kTextFieldWIDTHMARGIN - kTextFieldRightButtonW, (self.bounds.size.height - kTextFieldRightButtonH) / 2, kTextFieldRightButtonW, kTextFieldRightButtonH);
    }
}
#pragma mark 
- (void)addLeftImageView:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
- (void)addRightButtonWithDefaultImage:(NSString *)defaultImage highlightImage:(NSString *)highlightImage Action:(RightButtonBlock)rightButtonBlock
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setImage:[UIImage imageNamed:defaultImage] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _rightButtonBlock = rightButtonBlock;
    [self addSubview:_rightButton];
}
- (void)rightButtonAction:(id)sender
{
    _rightButtonBlock();
}
#pragma mark
//- (CGRect)borderRectForBounds:(CGRect)bounds;
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    CGFloat leftTotalW = self.leftView.bounds.size.width + kTextFieldWIDTHMARGIN + kTextFieldINTERVALWIDTH;
    CGFloat rightTotalW = kTextFieldWIDTHMARGIN + kTextFieldINTERVALWIDTH + kTextFieldDeleteButtonWH/*for delete xx*/ + (_rightButton != nil ? kTextFieldRightButtonW + kTextFieldINTERVALWIDTH : 0);
    return CGRectMake(leftTotalW, (self.bounds.size.height - rect.size.height) * 0.5, self.bounds.size.width - leftTotalW - rightTotalW, rect.size.height);
//    return CGRectMake(self.leftView.bounds.size.width + kTextFieldWIDTHMARGIN + kTextFieldINTERVALWIDTH, (self.bounds.size.height - rect.size.height) * 0.5, self.bounds.size.width - self.leftView.bounds.size.width - kTextFieldINTERVALWIDTH - kTextFieldINTERVALWIDTH - /*self.rightView.bounds.size.width*/kTextFieldDeleteButtonWH - kTextFieldINTERVALWIDTH - kTextFieldWIDTHMARGIN, rect.size.height);
}
//- (CGRect)placeholderRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    CGFloat leftTotalW = self.leftView.bounds.size.width + kTextFieldWIDTHMARGIN + kTextFieldINTERVALWIDTH;
    CGFloat rightTotalW = kTextFieldWIDTHMARGIN + kTextFieldINTERVALWIDTH + kTextFieldDeleteButtonWH/*for delete xx*/ + (_rightButton != nil ? kTextFieldRightButtonW + kTextFieldINTERVALWIDTH : 0);
    return CGRectMake(leftTotalW, (self.bounds.size.height - rect.size.height) * 0.5, self.bounds.size.width - leftTotalW - rightTotalW, rect.size.height);
}

//clearbutton和rightView二者只能显示一个，参见印象笔记
- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    
//    if (_rightButton != nil) {
//        return CGRectMake(281, 13, kTextFieldDeleteButtonWH, kTextFieldDeleteButtonWH);
        CGFloat rightTotalW = kTextFieldWIDTHMARGIN + (_rightButton != nil ? kTextFieldRightButtonW + kTextFieldINTERVALWIDTH : 0);
//        return CGRectMake(self.bounds.size.width - self.rightView.bounds.size.width - kTextFieldWIDTHMARGIN - kTextFieldINTERVALWIDTH - rect.size.width, (self.bounds.size.height - rect.size.height) * 0.5, rect.size.width, rect.size.height);
//    }else return CGRectMake(self.bounds.size.width - kTextFieldWIDTHMARGIN - rect.size.width, (self.bounds.size.height - rect.size.height) * 0.5, rect.size.width, rect.size.height);
    
    return  CGRectMake(self.bounds.size.width - rightTotalW - kTextFieldDeleteButtonWH, (self.bounds.size.height - rect.size.height) * 0.5, kTextFieldDeleteButtonWH, kTextFieldDeleteButtonWH);
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    if (self.leftView != nil) {
        self.leftView.contentMode = UIViewContentModeCenter;
        return CGRectMake(kTextFieldWIDTHMARGIN, 0, self.leftView.bounds.size.width, self.bounds.size.height);
    }else return CGRectZero;
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    if (self.rightView != nil) {
        self.rightView.contentMode = UIViewContentModeCenter;
        return CGRectMake(self.bounds.size.width  - self.rightView.bounds.size.width - kTextFieldWIDTHMARGIN, 0, self.rightView.bounds.size.width, self.bounds.size.height);
    }else return CGRectZero;
}
@end
