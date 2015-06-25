//
//  FYInfoCenterHeaderView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/19.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYInfoCenterHeaderView.h"
#import "FYInfoCenterAvatar.h"
@implementation FYInfoCenterHeaderView
{
    __weak IBOutlet FYInfoCenterAvatar *crownAvatar;
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UILabel *placeLabel;
    __weak IBOutlet UILabel *footLabel;
    __weak IBOutlet UILabel *rankLabel;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)setCrownAndAvatar
{
    crownAvatar.avatar = @"123";
    crownAvatar.level = 2;
}
@end
