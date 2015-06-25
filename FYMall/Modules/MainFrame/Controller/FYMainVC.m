//
//  FYMainVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/5.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYMainVC.h"
#import "FYRoundRectButton.h"
#import "FYRoundRectTextField.h"
#import "FYMainVCCell.h"
#import "LXActionSheet.h"
#import "FYDinnerVC.h"
#import "FYSearchMapVC.h"


#import "FYDinner.h"
#import "FYAccountTool.h"
#import "MJRefresh.h"

#define kRowHeight              152
#define kRowSeparatorHeight     5
@interface FYMainVC () <UITableViewDataSource, UITableViewDelegate, LXActionSheetDelegate>
{
    __weak IBOutlet FYRoundRectTextField *_searchTextField;
    __weak IBOutlet UITableView *_tableView;
    
    NSInteger _indexRow;     //dfy  how to get rid of it
}
@end
static NSString *Identity = @"MainVCTableCell";
@implementation FYMainVC
{
    NSMutableArray *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubviews];
    
//    _dataArray = [NSMutableArray array];
    [self loadData];
//    [_tableView.header  beginRefreshing];
}

- (void)setupSubviews
{
    self.title = @"首页";
    [_tableView registerNib:[UINib nibWithNibName:@"FYMainVCCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Identity];
    [_searchTextField addLeftImageView:@"iconfont-search"];
    [_searchTextField addRightButtonWithDefaultImage:@"iconfont-dingwei2" highlightImage:@"dingwei" Action:^{
        FYSearchMapVC *vc = [[FYSearchMapVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
//    [_tableView addLegendHeaderWithRefreshingBlock:^{
//        [self loadNewData];
//    }];
//    
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        [self loadMoreData];
//    }];

}


- (void)loadNewData
{
//    [[HTTPSessionManager sharedInstance] getAllShopInfoWithStart:0 page:1 key:@"" isDesc:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"getAllShopInfoWithStart success with responseObject : %@", responseObject);
//        if (![responseObject isKindOfClass:[NSArray class]]) return;
//        if ([responseObject count] == 0) return;
//        [_dataArray removeAllObjects];
//        for (id object in responseObject) {
//            if ([object isKindOfClass:[NSDictionary class]]) {
//                FYDinner *dinner = [[FYDinner alloc] initWithDic:object];
//                [_dataArray addObject:dinner];
//            }
//        }
//        [_tableView reloadData];
//        [_tableView.header endRefreshing];
//        NSLog(@"%@",_dataArray);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}
- (void)loadMoreData
{
//    [[HTTPSessionManager sharedInstance] getAllShopInfoWithStart:0 page:1 key:@"" isDesc:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"getAllShopInfoWithStart success with responseObject : %@", responseObject);
//        if (![responseObject isKindOfClass:[NSArray class]]) return;
//        if ([responseObject count] == 0) return;
//        for (id object in responseObject) {
//            if ([object isKindOfClass:[NSDictionary class]]) {
//                FYDinner *dinner = [[FYDinner alloc] initWithDic:object];
//                [_dataArray addObject:dinner];
//            }
//        }
//        [_tableView reloadData];
//        [_tableView.footer endRefreshing];
//        NSLog(@"%@",_dataArray);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}
- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DinnerList" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        FYDinner *dinner = [[FYDinner alloc] initWithDic:dic];
        [mutableArray addObject:dinner];
    }
    
    _dataArray = [NSMutableArray arrayWithArray:mutableArray];
    
//    NSMutableArray *mutableArray = [NSMutableArray array];
    
//    [[HTTPSessionManager sharedInstance] getAllShopInfoWithStart:0 page:1 key:@"" isDesc:YES success:^(NSURLSessionDataTask *task, id responseObject) {
////        NSLog(@"getAllShopInfoWithStart success with responseObject : %@", responseObject);
//        for (id object in responseObject) {
//            if ([object isKindOfClass:[NSDictionary class]]) {
//                FYDinner *dinner = [[FYDinner alloc] initWithDic:object];
//                [mutableArray addObject:dinner];
//            }
//        }
//        _dataArray = [NSArray arrayWithArray:mutableArray];
//        [_tableView reloadData];
//        NSLog(@"%@",_dataArray);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray != nil) {
        return _dataArray.count;
    } else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYMainVCCell *cell = [tableView dequeueReusableCellWithIdentifier:Identity];
//    cell.dic = _dataArray[indexPath.row];
    cell.dinner = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight + kRowSeparatorHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexRow = indexPath.row;
    if (![FYAccountTool sharedFYAccountTool].account) {
        [self showAccountActionSheet];
    } else {
        FYDinnerVC *vc = [[FYDinnerVC alloc] initWithShopID:[_dataArray[_indexRow] valueForKey:@"shopid"]];
//        vc.dinner = _dataArray[_indexRow];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 注册登录
- (void)showAccountActionSheet
{
    LXActionSheet *actionSheet = [[LXActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"快速使用" otherButtonTitles:@[@"注册/登陆"]];
    [actionSheet showInView:self.view];
}
#pragma mark LXActionSheet Delegate
- (void)didClickOnButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            FYDinnerVC *vc = [[FYDinnerVC alloc] initWithShopID:[_dataArray[_indexRow] valueForKey:@"shopid"]];
//            vc.dinner = _dataArray[_indexRow];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kFYShowLoginNotification object:self];
        }
            break;
        case 2:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kFYShowLoginNotification object:self];
        }
            break;
        case 3:
            break;
        default:
            break;
    }
}
@end
