//
//  AMTMyCommentsViewController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyCommentsViewController.h"
#import "AMTMyCommentsCell.h"
#import "AMTMyLikeViewModel.h"
@interface AMTMyCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTMyLikeViewModel *viewModel;
@end

@implementation AMTMyCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.titieLab.text = @"我的评论";
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModel.commentCommand execute:@[@(self.page)]] subscribeNext:^(id x) {
        weakSelf.page += 1;
        [weakSelf endRefresh];
        [weakSelf.tableView reloadData];
    }];
}

- (void)loadMoreToData
{
    [self setBingding];
}

- (void)loadNewData
{
    self.page = 1;
    [self setBingding];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTMyCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTMyCommentsCell class]) forIndexPath:indexPath];
    cell.model = self.viewModel.listArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 221;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN -NavHFit) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BHColor(@"ffffff");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_footer = self.footer;
        _tableView.mj_header = self.header;
        [_tableView registerClass:[AMTMyCommentsCell class] forCellReuseIdentifier:NSStringFromClass([AMTMyCommentsCell class])];
        
    }
    return _tableView;
}

- (AMTMyLikeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTMyLikeViewModel alloc]init];
    }
    return _viewModel;
}
@end
