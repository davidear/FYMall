//
//  FYRoundRectTextField.h
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTextFieldINTERVALWIDTH          5
#define kTextFieldWIDTHMARGIN            10
#define kTextFieldRightButtonW           30
#define kTextFieldRightButtonH           30

#define kTextFieldDeleteButtonWH         19
typedef void(^RightButtonBlock)();
@interface FYTextField : UITextField
{
    UIButton *_rightButton;
    RightButtonBlock _rightButtonBlock;
}
@property (strong, nonatomic) UIButton *rightButton;
- (void)setupUI;
- (void)addLeftImageView:(NSString *)imageName;
- (void)addRightButtonWithDefaultImage:(NSString *)defaultImage highlightImage:(NSString *)highlightImage Action:(RightButtonBlock)rightButtonBlock;
@end
