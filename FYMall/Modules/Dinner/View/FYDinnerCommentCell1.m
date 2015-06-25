//
//  FYDinnerCommentCell1.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/7.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerCommentCell1.h"
#import "UIButton+FY.h"
@implementation FYDinnerCommentCell1
{
    
    __weak IBOutlet UIImageView *leftImageView;
    __weak IBOutlet UILabel *mainLabel;
    __weak IBOutlet UILabel *likeCountLabel;
    
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    leftImageView.image = [UIImage imageNamed:_dic[@"image"]];
    mainLabel.text = _dic[@"name"];
    likeCountLabel.text = [NSString stringWithFormat:@"%d",[_dic[@"likeCount"] intValue]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickLike:(UIButton *)sender {
    sender.selected = sender.isSelected;
    [sender likeAnimation];
}
- (IBAction)Comment:(UIButton *)sender {
}
@end
