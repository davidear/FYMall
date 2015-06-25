//
//  FYInfoRenderView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/19.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYInfoRenderView.h"

@implementation FYInfoRenderView
{
    __weak IBOutlet UIImageView *colorProgressBar;
    
    __weak IBOutlet UIView *whiteBg;
}
- (void)awakeFromNib
{
    whiteBg.layer.cornerRadius = whiteBg.bounds.size.height / 2;
}
- (void)setUserInfo:(FYUserInfo *)userInfo
{
    _userInfo = userInfo;
}
- (void)progressAnimation
{
    if (colorProgressBar.frame.origin.x == -colorProgressBar.frame.size.width) {
        [UIView animateWithDuration:0.5f animations:^{
            colorProgressBar.frame = CGRectMake(- colorProgressBar.frame.size.width / 4, 0, colorProgressBar.frame.size.width, colorProgressBar.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
