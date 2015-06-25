//
//  FYDinnerCommentCellFrame.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerCommentCellFrame.h"

@implementation FYDinnerCommentCellFrame
- (void)setDinnerComment:(FYComment *)dinnerComment
{
    _dinnerComment = dinnerComment;
    
    
    CGFloat avatarX = kCellBorderWH;
    CGFloat avatarY = kCellBorderWH;
    CGSize avatarSize = CGSizeMake(33, 33);//需优化
    _avatarFrame = (CGRect){CGPointMake(avatarX, avatarY), avatarSize};
    
    CGFloat nameX = CGRectGetMaxX(_avatarFrame) + kCellBorderWH;
    CGSize nameSize = [_dinnerComment.name sizeWithAttributes:@{NSFontAttributeName : kNameFont}];
    CGFloat nameY = avatarY + avatarSize.height / 2 - nameSize.height / 2;
    _nameFrame = (CGRect){CGPointMake(nameX, nameY), nameSize};
    
    CGFloat detailX = nameX;
    CGFloat detailY = CGRectGetMaxY(_nameFrame) + kHeightMargin;;
    CGSize constrantSize = CGSizeMake(kTableWidth - kDetailRightMargin - _nameFrame.origin.x, MAXFLOAT);
    CGSize detailSize = [_dinnerComment.detail boundingRectWithSize:constrantSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kNameFont} context:nil].size;
    _detailFrame = (CGRect){CGPointMake(detailX, detailY), detailSize};
    
    CGFloat createdAtX = detailX;
    CGFloat createdAtY = CGRectGetMaxY(_detailFrame) + kCreatAtTopMargin;
    CGSize createdAtSize = [_dinnerComment.createdAt sizeWithAttributes:@{NSFontAttributeName : kCreatedAtFont}];
    _createdAtFrame = (CGRect){CGPointMake(createdAtX, createdAtY), createdAtSize};
    
    CGFloat commentX = kTableWidth - kCommentRightMargin - 13;//需优化
    CGFloat commentY = createdAtY;
    CGSize commentSize = CGSizeMake(13, 12);
    _commentFrame = (CGRect){CGPointMake(commentX, commentY), commentSize};
    
    CGSize likeCountSize = [[NSString stringWithFormat:@"%d", _dinnerComment.likeCount] sizeWithAttributes:@{NSFontAttributeName : kLikeCountFont}];
    CGSize likeImageSize = CGSizeMake(13, 12);//需优化
    CGSize likeSize = CGSizeMake(likeCountSize.width + likeImageSize.width + 10, likeImageSize.height);
    CGFloat likeX = commentX - kCellBorderWH - likeSize.width - 10;
    CGFloat likeY = createdAtY;
    _likeFrame = (CGRect){CGPointMake(likeX, likeY), likeSize};
    
    CGSize starSize = CGSizeMake(13, 12);//需优化
    CGFloat starX = likeX - kCellBorderWH - starSize.width;
    CGFloat starY = createdAtY;
    _starFrame = (CGRect){CGPointMake(starX, starY), starSize};
    
    _cellHeight = CGRectGetMaxY(_createdAtFrame) + kCellBorderWH + kCellMargin;
}
@end
