//
//  FYDinnerCommentVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/7.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYDinnerCommentVC.h"
#import "FYDinnerCommentCell1.h"
#import "FYDinnerCommentCell2.h"
#import "FYDinnerCommentHeadView.h"
#import "FYCommentView.h"

#import "FYNetwork.h"
#import "FYAccountTool.h"

#define kTableViewBgColor           [UIColor colorFromHexString:@"0xdadada"]
@interface FYDinnerCommentVC () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *IdentitySection0 = @"IdentitySection0";
static NSString *IdentitySection1 = @"IdentitySection01";

@implementation FYDinnerCommentVC
{
    __weak FYDinner *_dinner;
    NSArray *_dataArraySection0;
    NSArray *_cell2FrameArray;
    UITableView *_tableView;
    FYDinnerCommentHeadView *_headView;
}

- (id)initWithDinner:(FYDinner *)dinner
{
    self = [self init];
    if (self) {
        _dinner = dinner;
        
        self.extendedLayoutIncludesOpaqueBars = YES;
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kTableViewBgColor;
        [_tableView registerNib:[UINib nibWithNibName:@"FYDinnerCommentCell1" bundle:nil] forCellReuseIdentifier:IdentitySection0];
        [_tableView registerClass:[FYDinnerCommentCell2 class] forCellReuseIdentifier:IdentitySection1];
        [self.view addSubview:_tableView];
        
        _headView = [[NSBundle mainBundle] loadNibNamed:@"FYDinnerCommentHeadView" owner:nil options:nil][0];
        _headView.dinner = dinner;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self loadData];
}

- (void)loadData
{
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"DinnerComment1" ofType:@"plist"];
    _dataArraySection0 = [NSArray arrayWithContentsOfFile:path0];
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"DinnerComment2" ofType:@"plist"];
//    _dataArraySection1 = [NSArray arrayWithContentsOfFile:path1];
    
    NSMutableArray *mutArr = [NSMutableArray array];
//    for (NSDictionary *dic in _dataArraySection1) {
//        FYDinnerCommentCellFrame *cellFrame = [[FYDinnerCommentCellFrame alloc] init];
//        cellFrame.dinnerComment = [[FYComment alloc] initWithDic:dic];
//        [mutArr addObject:cellFrame];
//    }
//    _cell2FrameArray = [NSArray arrayWithArray:mutArr];
//    [_tableView reloadData];
    
    
//    [[HTTPSessionManager sharedInstance] getShopCommentsWithShopID:@"121" start:0 page:1 key:@"" isDesc:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"getShopCommentsWithShopID success with responseObject : %@", responseObject);
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in responseObject) {
//                FYDinnerCommentCellFrame *cellFrame = [[FYDinnerCommentCellFrame alloc] init];
//                cellFrame.dinnerComment = [[FYComment alloc] initWithDic:dic];
//                [mutArr addObject:cellFrame];
//            }
//            _cell2FrameArray = [NSArray arrayWithArray:mutArr];
//            [_tableView reloadData];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
}

- (void)setupSubviews
{
    self.title = _dinner.fullname;
    _tableView.frame = self.view.bounds;
    
}


#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 169;
        default:
            return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _headView;
    } else return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        FYDinnerCommentCellFrame *cellFrame = _cell2FrameArray[indexPath.row];
        return cellFrame.cellHeight ;
    }else return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            FYDinnerCommentCell1 *cell = [tableView dequeueReusableCellWithIdentifier:IdentitySection0];
            cell.dic = _dataArraySection0[indexPath.row];
            return cell;
        }
        case 1:
        {
            FYDinnerCommentCell2 *cell = [tableView dequeueReusableCellWithIdentifier:IdentitySection1];
            cell.cellFrame = _cell2FrameArray[indexPath.row];
            return cell;
        }
        default:
            return nil;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (_dataArraySection0 != nil) {
                return _dataArraySection0.count;
            }else return 0;
        case 1:
            if (_cell2FrameArray != nil) {
                return _cell2FrameArray.count;
            }else return 0;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [[FYCommentView commentView] showWithCommentTo:@"" shopid:@"" success:^{
            NSDictionary *dic = @{@"content" : @"特殊一条",
//                                  @"parentid" : @"0",
                                  @"shopid" : _dinner.shopid,
                                  @"userid" : [FYAccountTool sharedFYAccountTool].account.userid,
                                  @"username" : [FYAccountTool sharedFYAccountTool].account.username
                                  };
            [FYNetwork startEngine];
            [[FYNetwork sharedFYNetwork] HttpPostComment:dic success:^(id responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }];
    }
}
@end
