//
//  FYDinnerCommentCell2.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/8.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerCommentCell2.h"
//#import "UIButton+FY.h"
#import "FYLikeButton.h"
#import "UIImageView+WebCache.h"



@implementation FYDinnerCommentCell2
{
    UIImageView *_avatarImageView;
    UILabel *_nameLabel;
    UILabel *_detailLabel;
    UILabel *_createdAtLabel;
    UIButton *_starButton;
    FYLikeButton *_likeButton;
    UIButton * _commentButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
//    self.backgroundColor = [UIColor redColor];
    frame.origin.x = kCellSideMargin;
    frame.origin.y += kCellMargin;
    frame.size.width -= kCellSideMargin * 2;
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

- (void)initSubviews
{

    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.clipsToBounds = YES;
    [self.contentView addSubview:_avatarImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = kNameFont;
    _nameLabel.textColor = kNameColor;
    [self.contentView addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = kNameFont;
    _detailLabel.textColor = kDetailColor;
    _detailLabel.numberOfLines = 0;
    [self.contentView addSubview:_detailLabel];
    
    _createdAtLabel = [[UILabel alloc] init];
    _createdAtLabel.font = kCreatedAtFont;
    _createdAtLabel.textColor = kNameColor;
    [self.contentView addSubview:_createdAtLabel];
    
    _starButton = [[UIButton alloc] init];
    [_starButton addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_starButton setBackgroundImage:[UIImage imageNamed:@"收藏02"] forState:UIControlStateNormal];
    [_starButton setBackgroundImage:[UIImage imageNamed:@"收藏01"] forState:UIControlStateSelected];
    [self.contentView addSubview:_starButton];
    
    _likeButton = [[FYLikeButton alloc] init];
    [_likeButton addTarget:self action:@selector(likeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_likeButton setImage:[UIImage imageNamed:@"赞01"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"赞02"] forState:UIControlStateSelected];
    [_likeButton.titleLabel setFont:kLikeCountFont];
    [_likeButton setTitleColor:kNameColor forState:UIControlStateNormal];
    [self.contentView addSubview:_likeButton];
    
    _commentButton = [[UIButton alloc] init];
    [_commentButton addTarget:self action:@selector(commentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"huifu1"] forState:UIControlStateNormal];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"huifu2"] forState:UIControlStateSelected];
    [self.contentView addSubview:_commentButton];
}

- (void)setCellFrame:(FYDinnerCommentCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    FYComment *dinnerComment = _cellFrame.dinnerComment;
    
    _avatarImageView.frame = _cellFrame.avatarFrame;
    _avatarImageView.layer.cornerRadius = _cellFrame.avatarFrame.size.height / 2;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:dinnerComment.avatar] placeholderImage:[UIImage imageNamed:@"图片占位"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    _nameLabel.frame = _cellFrame.nameFrame;
    _nameLabel.text = dinnerComment.name;
    
    _detailLabel.frame = _cellFrame.detailFrame;
    _detailLabel.text = dinnerComment.detail;
    
    _createdAtLabel.frame = _cellFrame.createdAtFrame;
    _createdAtLabel.text = dinnerComment.createdAt;
    
    _starButton.frame = _cellFrame.starFrame;
    
    _likeButton.frame = _cellFrame.likeFrame;
    [_likeButton setTitle:[NSString stringWithFormat:@"%d", dinnerComment.likeCount] forState:UIControlStateNormal];
    
    _commentButton.frame = _cellFrame.commentFrame;
}
#pragma mark - Button Action
- (void)likeClicked:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}
- (void)starClicked:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

- (void)commentClicked:(id)sender
{
    
}
#pragma mark
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
