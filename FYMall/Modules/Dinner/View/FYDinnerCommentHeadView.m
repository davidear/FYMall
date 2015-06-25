//
//  FYDinnerCommentHeadView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerCommentHeadView.h"
#import "UIButton+WebCache.h"

@implementation FYDinnerCommentHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setDinner:(FYDinner *)dinner
{
    _dinner = dinner;
//    NSString *urlStr = [kFYNetworkBaseURLStr stringByAppendingPathComponent:_dinner.logoUrl];
    [_dinnerAvatar sd_setImageWithURL:[NSURL URLWithString:_dinner.logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片占位"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    _dinnerNameLabel.text = _dinner.fullname;
    _dinnerAvatar.clipsToBounds = YES;
    _dinnerAvatar.layer.cornerRadius = _dinnerAvatar.bounds.size.height / 2;
}
- (IBAction)callService:(id)sender {
//    [[NSNotificationCenter defaultCenter] postNotificationName:kFYDidEnterBeaconRegion object:nil userInfo:@{@"shopID" : @"1"}];
}

@end
