//
//  AMTDetailsVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsVC.h"

#import "AMTGoodsMessageCell.h"
#import "AMTDetailsViewModel.h"
@interface AMTDetailsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTDetailsViewModel *viewModels;
@end

@implementation AMTDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = @"详情";
    [self.view addSubview:self.tableView];
    [self setBingDing];
}

- (void)setBingDing
{
    weakSelf(self);
    [[self.viewModels.detailsCommand execute:@[@"1"]] subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
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
    cell.model = self.viewModels.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath model:self.viewModels.model keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN];
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

- (AMTDetailsViewModel *)viewModels
{
    if (!_viewModels) {
        _viewModels = [[AMTDetailsViewModel alloc]init];
    }
    return _viewModels;
}
@end
