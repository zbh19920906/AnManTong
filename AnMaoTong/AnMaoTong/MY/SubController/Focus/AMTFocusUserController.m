//
//  AMTFocusUserController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFocusUserController.h"
#import "AMTFocusUserCell.h"
#import "AMTFocusViewModel.h"
@interface AMTFocusUserController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTFocusViewModel *viewModel;
@end

@implementation AMTFocusUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModel.listCommand execute:@[@(1),@(2)]] subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTFocusUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTFocusUserCell class]) forIndexPath:indexPath];
    cell.model = self.viewModel.listArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
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
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, self.view.height - 40 -NavHFit) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BHColor(@"ffffff");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[AMTFocusUserCell class] forCellReuseIdentifier:NSStringFromClass([AMTFocusUserCell class])];
        
    }
    return _tableView;
}

- (AMTFocusViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTFocusViewModel alloc]init];
    }
    return _viewModel;
}
@end
