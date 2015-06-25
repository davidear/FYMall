//
//  FYAnimationButton.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/22.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYAnimationButton.h"

@implementation FYAnimationButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self buttonAnimation];
}
- (void)buttonAnimation
{
    
}
@end
