//
//  UIButton+FY.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "UIButton+FY.h"

@implementation UIButton (FY)
- (void)likeAnimation
{
    CAKeyframeAnimation * keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAni.duration = 0.5f;
    keyframeAni.values = @[@(0.1), @(1.5), @(1.0)];
    keyframeAni.keyTimes = @[@(0),@(0.8),@(1)];
    keyframeAni.calculationMode = kCAAnimationLinear;
    [self.layer addAnimation:keyframeAni forKey:@"like"];
}

@end
