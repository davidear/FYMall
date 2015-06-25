//
//  FYLineUpView.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//
#define kRadarWH                150
#define kUpMarginFromCenter     60
#define kDownMarginFromCenter   30
#define kLabelW                 150
#define kLabelH                 100
#import "FYLineUpView.h"

@implementation FYLineUpView
{
    UILabel *_label;
    UILabel *_mainLabel;
    NSTimer *_timer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6f;
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2 - kLabelW / 2, frame.size.height / 2 + kDownMarginFromCenter, kLabelW, kLabelH)];
        _mainLabel.textColor = [UIColor whiteColor];
        _mainLabel.numberOfLines = 0;
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mainLabel];
    }
    return self;
}

- (void)setLineTextWithPeople:(int)people minutes:(int)minutes
{
    _mainLabel.text = [NSString stringWithFormat:@"排队中...\n您前面共有%d人\n预计%d分钟", people, minutes];
}

- (void)setAnimationWithCircleCount:(int)count color:(UIColor *)color duration:(double)duration seconds:(int)second
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    _label.textColor = color;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    [_label setText:[NSString stringWithFormat:@"%d",second]];
    CGRect rect = CGRectMake(self.center.x - kRadarWH / 2, self.center.y - kRadarWH / 2 - kUpMarginFromCenter, kRadarWH, kRadarWH);
    _label.center = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    //    });
    
    [self addSubview:_label];
    
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    baseAni.fromValue = [NSNumber numberWithFloat:1];
    baseAni.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation *baseBni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseBni.fromValue = [NSNumber numberWithDouble:0.3f];
    baseBni.toValue = [NSNumber numberWithDouble:1.0f];;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setAnimations:@[baseBni,baseAni]];
    group.repeatCount = FLT_MAX;
    group.duration = duration;
    group.removedOnCompletion = YES;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    for (int i = 0; i < count; i++) {
        UIView *aniView = [[UIView alloc] initWithFrame:rect];
        aniView.alpha = 0;
        [self addSubview:aniView];
        aniView.layer.borderColor = color.CGColor;
        aniView.layer.cornerRadius = rect.size.width * 0.5;
        aniView.layer.borderWidth = 5;
        aniView.clipsToBounds = YES;
        aniView.backgroundColor = [UIColor clearColor];
        float delta = duration / count / 2 * i;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delta * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [aniView.layer addAnimation:group forKey:nil];
        });
    }
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.6;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissFromView
{
    [_timer invalidate];
    _label = nil;
    _mainLabel = nil;
    [self removeFromSuperview];
}

- (void)refreshLabelText
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _label.text = [NSString stringWithFormat:@"%d", [_label.text intValue] - 1];
    });
    if (0) {
        
    }
}
@end
