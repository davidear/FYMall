//
//  FYVerifyView.h
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYVerifyView.h"
typedef void(^SuccessBlock)();
typedef void(^ResendVerifyMSGBlock)();
@interface FYVerifyView : UIView
@property (strong, nonatomic) SuccessBlock success;
- (void)showInView:(UIView *)view phone:(NSString *)phone success:(SuccessBlock)success;
@end
