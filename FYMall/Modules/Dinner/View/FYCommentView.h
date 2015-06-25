//
//  FYCommentView.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/15.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)();
typedef void(^ResendVerifyMSGBlock)();
@interface FYCommentView : UIView
@property (strong, nonatomic) SuccessBlock success;
+ (id)commentView;
- (void)showWithCommentTo:(NSString *)oldComment shopid:(NSString *)shopid success:(SuccessBlock)success;
@end
