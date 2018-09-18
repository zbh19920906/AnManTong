//
//  AMTMerchantDetalisController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMerchantDetalisController.h"
#import "AMTDetailsHeadView.h"
#import "AMTDetailsClassView.h"
#import "AMTUserDetailsViewModel.h"
@interface AMTMerchantDetalisController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTUserDetailsViewModel *viewModel;
@end

@implementation AMTMerchantDetalisController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModel.userInfoCommand execute:@[self.user_id,@(self.type)]] subscribeNext:^(id x) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 0 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell identifier] forIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        AMTDetailsHeadView *h = [[AMTDetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100)];
        return h;
    }
    AMTDetailsClassView *headView = [[AMTDetailsClassView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40)];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 305 : 40;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:[BaseTableViewCell identifier]];
    }
    return _tableView;
}

- (AMTUserDetailsViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTUserDetailsViewModel alloc]init];
    }
    return _viewModel;
}
@end
