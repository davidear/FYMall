//
//  FYRoundRectTextField.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/21.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYRoundRectTextField.h"

@implementation FYRoundRectTextField

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
}

@end
