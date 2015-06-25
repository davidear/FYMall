//
//  FYLeftMenuVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/5.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYLeftMenuVC.h"
#import "Colours.h"
#import "FYAccountTool.h"
#import "FYSettingHeaderVC.h"
#import "UIButton+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FYtool.h"
#import "FYInfoCenterVC.h"
#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"
#import "MobClick.h"

#define kRowHeight              44
#define kCellTextFont           [UIFont systemFontOfSize:14]
#define kCellTextColor          [UIColor colorFromHexString:@"0x362e2b"]
#define kCellSeparatorColor     [UIColor colorFromHexString:@"0xE5E5E5"]

#define kLeftMenuProportion                 0.75
@interface FYLeftMenuVC () <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UIButton *_avatarButton;
    __weak IBOutlet UILabel *_userNameLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    UITableView *_tableView;
}
@end
static NSString *Identity = @"Identity";
@implementation FYLeftMenuVC
{
    NSArray *_dataArray;
}
- (id)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAccountInfoChanged:) name:kFYAccountInfoNotification object:nil];
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self setupSubviews];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LeftMenu" ofType:@"plist"];
    _dataArray = [NSArray arrayWithContentsOfFile:path];
    [_tableView reloadData];
}
- (void)setupSubviews
{
    _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width * kLeftMenuProportion, self.view.bounds.size.height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"FYHeadInfo" owner:self options:nil][0];
    
    
    _avatarButton.backgroundColor = [UIColor redColor];
    _avatarButton.clipsToBounds = YES;
    _avatarButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarButton.layer.borderWidth = 2;
    _avatarButton.layer.cornerRadius = _avatarButton.bounds.size.width / 2;
    
    [self onAccountInfoChanged:nil];
}
- (IBAction)userInfo:(id)sender {
    if ([[FYAccountTool sharedFYAccountTool].account valueForKey:@"token"]) {
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied | [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
            [FYtool showMsg:@"请在隐私设置允许Gourmet使用照片库"];
        } else {
            FYSettingHeaderVC *vc = [[FYSettingHeaderVC alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kFYShowLoginNotification object:self];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identity];
        UIImageView *grayLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRowHeight -1, tableView.bounds.size.width, 1)];
        grayLine.backgroundColor = kCellSeparatorColor;
        [cell addSubview:grayLine];
    }
    
    cell.textLabel.font = kCellTextFont;
    cell.textLabel.textColor = kCellTextColor;
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.textLabel.text = _dataArray[indexPath.row][@"text"];
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row][@"imageName"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"editUserInfo"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.sideMenuViewController hideMenuViewController];
    
    FYInfoCenterVC *vc = [[FYInfoCenterVC alloc] init];
    UINavigationController *navi = (UINavigationController *)self.sideMenuViewController.contentViewController;
    [navi pushViewController:vc animated:YES];
}

- (void)onAccountInfoChanged:(NSNotification *)aNotification
{
    FYAccount *account = [FYAccountTool sharedFYAccountTool].account;
    [_avatarButton sd_setImageWithURL:[NSURL URLWithString:account.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片占位"] options:SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageRefreshCached];
    _userNameLabel.text = account.username;
    _phoneLabel.text = account.phone;
}
@end
