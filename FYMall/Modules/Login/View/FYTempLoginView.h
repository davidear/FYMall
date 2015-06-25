//
//  FYTempLoginView.h
//  FYMall
//
//  Created by dai.fengyi on 15/4/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

//#import "FYView.h"
typedef void(^AvatarBlock)(UIImagePickerControllerSourceType sourceType);
@interface FYTempLoginView : UIView
@property (strong, nonatomic) AvatarBlock avatarBlock;
- (void)showInView:(UIView *)view AvatarBlock:(AvatarBlock)avatarBlock;
@end
