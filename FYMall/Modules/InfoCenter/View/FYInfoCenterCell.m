//
//  FYInfoCenterCell.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/20.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYInfoCenterCell.h"

@implementation FYInfoCenterCell
{
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *frequencyLabel;
    __weak IBOutlet UILabel *dinnerLabel;
    __weak IBOutlet UILabel *consumptionLabel;
    __weak IBOutlet UIImageView *dinnerLogo;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FYInfoCenterCell" owner:nil options:nil] firstObject];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
