//
//  FYInfoCenterVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/19.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYInfoCenterVC.h"
#import "UIImage+FY.h"
#import "FYInfoRenderView.h"
#import "FYInfoCenterHeaderView.h"
#import "FYInfoCenterCell.h"
#import "FYUserInfoSettingTVC.h"

@interface FYInfoCenterVC () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation FYInfoCenterVC
{
    UITableView *_tableView;
    
}
static NSString *identifier = @"infoCenterCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews
{
    self.title = @"个人中心";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic-shezhi-black"] style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    
    FYInfoRenderView *renderView = [[[NSBundle mainBundle] loadNibNamed:@"FYInfoRenderView" owner:nil options:nil] firstObject];
    renderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"FYInfoCenterHeaderView" owner:nil options:nil] firstObject];
    [self.view addSubview:_tableView];
    
    _tableView.backgroundView = renderView;
    
    _tableView.pagingEnabled = YES;
    _tableView.contentInset = UIEdgeInsetsMake(490, 0, 0, 0);
}
- (void)setting:(id)sender
{
    FYUserInfoSettingTVC *tvc = [[FYUserInfoSettingTVC alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:tvc animated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [((FYInfoCenterHeaderView *)_tableView.tableHeaderView) setCrownAndAvatar];
}
#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FYInfoCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
#pragma mark - ScrollView Delegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView.contentOffset.y > 0) {
//        _tableView.pagingEnabled = NO;
//    } else {
//        _tableView.pagingEnabled = YES;
//    }
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y > (255 - 64)) {
//        _tableView.pagingEnabled = NO;
//    } else {
//        _tableView.pagingEnabled = YES;
//    }
//}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 50) {
        _tableView.pagingEnabled = NO;
        _tableView.contentInset = UIEdgeInsetsZero;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0) {
        _tableView.pagingEnabled = YES;
        _tableView.contentInset = UIEdgeInsetsMake(490, 0, 0, 0);
    }
    
    if (scrollView.contentOffset.y == -490) {
        [((FYInfoRenderView *)_tableView.backgroundView) progressAnimation];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > (255 - 64)) {
        if (self.navigationController.navigationBar.clipsToBounds == YES) {
            [self opaqueBar];
        }
    } else {
        if (self.navigationController.navigationBar.clipsToBounds == NO) {
            [self translucentBar];
        }
    }
}
#pragma mark - navigationBar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self scrollViewDidScroll:_tableView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self opaqueBar];
}

#pragma mark - navigationBar setting
- (void)opaqueBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageResizedWithName:@"2*2PX橙色点"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)translucentBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"beijing"] forBarMetrics:UIBarMetricsCompact];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
@end
