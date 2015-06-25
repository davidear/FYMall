//
//  FYLikeButton.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/9.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYLikeButton.h"
@implementation FYLikeButton

- (void)setupUI
{
    [super setupUI];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setCount:(int)count
{
    [self setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
}

- (int)count
{
    return [self.titleLabel.text intValue];
}

- (void)buttonAnimation
{
    CAKeyframeAnimation * keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAni.duration = 0.5f;
    keyframeAni.values = @[@(0.1), @(1.5), @(1.0)];
    keyframeAni.keyTimes = @[@(0),@(0.8),@(1)];
    keyframeAni.calculationMode = kCAAnimationLinear;
    [self.imageView.layer addAnimation:keyframeAni forKey:@"like"];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.count = self.count + (self.selected ? 1 : -1);
}
@end
