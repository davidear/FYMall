//
//  FYDinnerCommentCellFrame.h
//  FYMall
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYComment.h"

#define kTableBoardWidth        7
#define kTableWidth             [UIScreen mainScreen].bounds.size.width - 2 * kTableBoardWidth
#define kCellBorderWH           5
#define kNameFont               [UIFont systemFontOfSize:14]
#define kCreatedAtFont          [UIFont systemFontOfSize:10]
#define kLikeCountFont          [UIFont systemFontOfSize:11]
#define kHeightMargin           14

#define kDetailRightMargin      17
#define kCreatAtTopMargin       10
#define kCommentRightMargin     21

#define kCellMargin             5
#define kCellSideMargin         7

#define kDetailColor            [UIColor colorFromHexString:@"0x7c7c7c"]
#define kNameColor              [UIColor colorFromHexString:@"0x9e9e9e"]
@interface FYDinnerCommentCellFrame : NSObject
@property (strong, nonatomic) FYComment *dinnerComment;

@property (nonatomic, readonly) CGFloat cellHeight;

@property (nonatomic, readonly) CGRect avatarFrame;
@property (nonatomic, readonly) CGRect nameFrame;
@property (nonatomic, readonly) CGRect detailFrame;
@property (nonatomic, readonly) CGRect createdAtFrame;
@property (nonatomic, readonly) CGRect starFrame;
@property (nonatomic, readonly) CGRect likeFrame;
@property (nonatomic, readonly) CGRect commentFrame;
@end
