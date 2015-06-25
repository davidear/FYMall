//
//  FYAdvertiseScrollView.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/5.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYAdvertiseView : UIView <UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *imageArray;
@property (assign, nonatomic) BOOL autoSlide;

@end
