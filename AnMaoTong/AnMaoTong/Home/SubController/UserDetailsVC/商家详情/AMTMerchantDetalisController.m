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
@property (nonatomic, strong) AMTDetailsClassView *headView;
@end

@implementation AMTMerchantDetalisController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBar.titieLab.textColor = [UIColor clearColor];
    self.navBar.lineView.hidden = YES;
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModel.userInfoCommand execute:@[self.user_id,@(self.type)]] subscribeNext:^(id x) {
        weakSelf.navBar.titieLab.text = weakSelf.viewModel.userInfoModel.nickname;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [[self.viewModel.dynamicCommand execute:@[@(1),weakSelf.user_id,@(weakSelf.type)]]subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 0 : self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = BHColor(@"f5f5f5");
    AMTDetailsModel *model = self.viewModel.listArray[indexPath.row];
    cell.model = model;
    
    weakSelf(self);
    [[[cell.headTap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id x) {
        AMTMerchantDetalisController *vc = [[AMTMerchantDetalisController alloc]init];
        vc.user_id = model.user_business_id;
        vc.type = model.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        AMTDetailsHeadView *h = [[AMTDetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100)];
        h.userInfoModel = self.viewModel.userInfoModel;
        return h;
    }
    
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath model:self.viewModel.listArray[indexPath.row] keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN] +10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 305 : 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    self.navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:offsetY /240];
    self.navBar.titieLab.textColor = [[UIColor blackColor] colorWithAlphaComponent:offsetY /240];
    if (offsetY >= 240) {
        self.tableView.contentInset = UIEdgeInsetsMake(NavHFit, 0, 0, 0);
        self.headView.backgroundColor = BHColor(@"FBFCFD");
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.headView.backgroundColor = [UIColor blackColor];
    }
    
}


- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
       [_tableView registerClass:[AMTGoodsMessageCell class] forCellReuseIdentifier:[AMTGoodsMessageCell identifier]];
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

- (AMTDetailsClassView *)headView
{
    if (!_headView) {
        _headView = [[AMTDetailsClassView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40)];
        
        weakSelf(self);
        [[_headView rac_signalForSelector:@selector(requsetData:)] subscribeNext:^(id x) {
            NSInteger i = x;
            if (i == 1) {
                [[weakSelf.viewModel.dynamicCommand execute:@[@(1),weakSelf.user_id,@(weakSelf.type)]]subscribeNext:^(id x) {
                    [weakSelf.tableView reloadData];
                }];
            }else{
                
            }
        }];
    }
    return _headView;
}
@end
