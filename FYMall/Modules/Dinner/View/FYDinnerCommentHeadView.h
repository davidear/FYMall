//
//  FYDinnerCommentHeadView.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYDinner.h"
@interface FYDinnerCommentHeadView : UIView
@property (weak, nonatomic) FYDinner *dinner;

@property (weak, nonatomic) IBOutlet UIButton *dinnerAvatar;
@property (weak, nonatomic) IBOutlet UILabel *dinnerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

@end
