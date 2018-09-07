//
//  AMTPersonalViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalViewController.h"
#import "AMTPersonalCell.h"
#import "AMTAnnouncementCell.h"
@interface AMTPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) BaseTableView *tableView;
@end

@implementation AMTPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = self.isUser ? @"个人资料" : @"商家资料";
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AMTAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTAnnouncementCell class]) forIndexPath:indexPath];
        return cell;
    }
    AMTPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTPersonalCell class]) forIndexPath:indexPath];
    cell.title = self.titleArr[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 100 : 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTPersonalCell class] forCellReuseIdentifier:NSStringFromClass([AMTPersonalCell class])];
        [_tableView registerClass:[AMTAnnouncementCell class] forCellReuseIdentifier:NSStringFromClass([AMTAnnouncementCell class])];
    }
    return _tableView;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = self.isUser ? @[@[@"更换头像",@"昵称",@"性别",@"出生年月",@"微信号",@"QQ号"]] : @[@[@"更换头像",@"商家名称",@"微信号",@"QQ号"],@[@"公告"]];
    }
    return _titleArr;
}
@end
