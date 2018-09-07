//
//  AMTDetailsVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsVC.h"
#import "AMTDetailsModel.h"
#import "AMTGoodsMessageCell.h"
@interface AMTDetailsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) AMTDetailsModel *model;
@property (nonatomic, strong) BaseTableView *tableView;
@end

@implementation AMTDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = @"详情";
    self.model = [[AMTDetailsModel alloc]init];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0.01 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTGoodsMessageCell class] forCellReuseIdentifier:NSStringFromClass([AMTGoodsMessageCell class])];
    }
    return _tableView;
}

@end
