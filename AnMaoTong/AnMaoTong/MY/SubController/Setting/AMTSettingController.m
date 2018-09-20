//
//  AMTSettingController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/20.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTSettingController.h"
#import "ForgetPwdOneController.h"
#import "AMTSettingViewModel.h"
@interface AMTSettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTSettingViewModel *viewModel;
@end

@implementation AMTSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView
{
    self.navBar.titieLab.text = @"设置";
    self.titleArr = @[@"修改密码",@"清除缓存",@"关于安贸通"];
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ForgetPwdOneController *vc = [[ForgetPwdOneController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    [cell.textLabel setLableColor:@"666666" font:14 bold:0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BaseView *footer = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 59)];
    footer.backgroundColor = tableView.backgroundColor;
    
    BaseButton *button = [BaseButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 9, WIDTH_SCREEN, 50);
    [button setLableColor:@"222222" font:16 bold:0];
    [button setBackgroundColor:BHColor(@"FFFFFF")];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    weakSelf(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UserHelper savePersonalInfoToCacheWith:[NSDictionary dictionary]];
        [weakSelf.viewModel.outLoginCommand execute:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [footer addSubview:button];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 59;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (AMTSettingViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTSettingViewModel alloc]init];
    }
    return _viewModel;
}
@end
