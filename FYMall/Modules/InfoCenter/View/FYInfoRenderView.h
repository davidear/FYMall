//
//  FYInfoRenderView.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/19.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYUserInfo;
@interface FYInfoRenderView : UIView
@property (weak, nonatomic) FYUserInfo *userInfo;
- (void)progressAnimation;
@end
