//
//  FYLineUpView.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

//#import "FYView.h"

@interface FYLineUpView : UIView
- (void)setLineTextWithPeople:(int)people minutes:(int)minutes;

- (void)setAnimationWithCircleCount:(int)count color:(UIColor *)color duration:(double)duration seconds:(int)second;

- (void)showInView:(UIView *)view;

- (void)dismissFromView;
@end

//FYLineUpView *view = [[FYLineUpView alloc] initWithFrame:self.view.bounds];
//[view setLineTextWithPeople:15 minutes:10];
//[view setAnimationWithCircleCount:4 color:[UIColor whiteColor] duration:3.0f frame:CGRectMake(self.view.bounds.size.width / 2 - 100, 100, 200, 200) seconds:60];
//[view showInView:self.view];