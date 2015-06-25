//
//  FYUserInfoSettingTVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/20.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYUserInfoSettingTVC.h"
#import "FYRoundRectButton.h"
#import "FYUserPhoneReset1VC.h"
@interface FYUserInfoSettingTVC ()

@end

@implementation FYUserInfoSettingTVC
{
    NSArray *_titleArray;
}
static NSString *identifier = @"userInfoSettingCell";
static NSString *avatarIdentifier = @"avatarIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
}

- (void)loadData
{
    _titleArray = @[@[@"头像", @"昵称", @"手机", @"性别", @"年龄/生日", @"标签/口味"],@[@"修改密码", @"退出", @"关于我们"]];
}
#pragma mark - Table view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else return 27;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 &indexPath.row == 0 ? 100 : 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_titleArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 & indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:avatarIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:avatarIdentifier];
            FYRoundRectButton *avatarButton = [[FYRoundRectButton alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
            avatarButton.userInteractionEnabled = NO;
            cell.accessoryView = avatarButton;
        }
        cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
        [((FYRoundRectButton *)cell.accessoryView) setImage:[UIImage imageNamed:@"gr-toux"] forState:UIControlStateNormal];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        // Configure the cell...
        cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = @"某某某";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 2:
            {
                FYUserPhoneReset1VC *vc = [[FYUserPhoneReset1VC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                break;
            default:
                break;
        }
    }
}
@end
