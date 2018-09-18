//
//  AMTMyCollectionViewController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyCollectionViewController.h"
#import "AMTMyCollectionCell.h"
#import "AMTCollectionViewModel.h"
@interface AMTMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTCollectionViewModel *viewModel;
@end

@implementation AMTMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.titieLab.text = self.isHistory ?  @"浏览历史" :  @"我的收藏";
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModel.collectionCommand execute:@[@"1",@(self.isHistory)]] subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTMyCollectionCell class]) forIndexPath:indexPath];
    cell.isHistory = self.isHistory;
    cell.model = self.viewModel.listArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN -NavHFit) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BHColor(@"ffffff");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[AMTMyCollectionCell class] forCellReuseIdentifier:NSStringFromClass([AMTMyCollectionCell class])];
        
    }
    return _tableView;
}

- (AMTCollectionViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTCollectionViewModel alloc]init];
    }
    return _viewModel;
}
@end
