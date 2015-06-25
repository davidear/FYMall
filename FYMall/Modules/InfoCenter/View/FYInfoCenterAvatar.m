//
//  FYInfoCenterAvatar.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/20.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYInfoCenterAvatar.h"
#import "UIImageView+WebCache.h"

@implementation FYInfoCenterAvatar
{
    UIImageView *_avatarImageView;
    UIImageView *_crown;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 78, 77)];
    _avatarImageView.layer.cornerRadius = 77.0 / 2;
    _avatarImageView.clipsToBounds = YES;
    _crown = [[UIImageView alloc] initWithFrame:CGRectMake(9, 0, 86, 27)];
    [self addSubview:_crown];
    [self addSubview:_avatarImageView];
}

- (void)setAvatar:(NSString *)avatar
{
    _avatar = avatar;
//    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_avatar] placeholderImage:[UIImage imageNamed:@"图片占位"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    _avatarImageView.backgroundColor = [UIColor redColor];
    _avatarImageView.image = [UIImage imageNamed:@"gr-toux"];
}

- (void)setLevel:(int)level
{
    _level = level;
    _crown.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic-huangguan"]];
}
@end
