//
//  MainVCCell.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/6.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYMainVCCell.h"
#import "UIButton+WebCache.h"
@interface FYMainVCCell()
@property (weak, nonatomic) IBOutlet UILabel *dinnerName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *dinnerImageButton;
@property (weak, nonatomic) IBOutlet UILabel *dinnerIntroduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerRecommendLabel;


@end
@implementation FYMainVCCell
- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    _dinnerImageButton.clipsToBounds = YES;
    _dinnerImageButton.layer.cornerRadius = _dinnerImageButton.bounds.size.height / 2;
}
- (void)setDinner:(FYDinner *)dinner
{
    _dinner = dinner;
    _dinnerName.text = _dinner.fullname;
    _distanceLabel.text = dinner.distance;
//    NSString *urlStr = [kFYNetworkBaseURLStr stringByAppendingPathComponent:_dinner.logoUrl];
    [_dinnerImageButton sd_setImageWithURL:[NSURL URLWithString:_dinner.logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片占位"]];
    _dinnerIntroduceLabel.text = _dinner.introducce;
    _dinnerRecommendLabel.text = _dinner.recommend;
}
//- (void)setDic:(NSDictionary *)dic
//{
//    _dic = dic;
//    _dinnerName.text = [_dic objectForKey:@"name"];
//    _distanceLabel.text = [_dic objectForKey:@"distance"];
//    [_dinnerImageButton setImage:[UIImage imageNamed:[_dic objectForKey:@"image"]] forState:UIControlStateNormal];
//    _dinnerIntroduceLabel.text = [_dic objectForKey:@"introduce"];
//    _dinnerRecommendLabel.text = [_dic objectForKey:@"recommend"];
//}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
////    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 152);
//    NSLog(@"layoutsubviews");
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    NSLog(@"drawRect");
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 152);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark 按钮事件
- (IBAction)lineUp:(id)sender {
}

@end
