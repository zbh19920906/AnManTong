//
//  AMTZoneMainController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTZoneMainController.h"
#import "AMTHomeViewModel.h"
#import "AMTBannerCell.h"
#import "AMTHeadView.h"
@interface AMTZoneMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTHomeViewModel *viewModels;
@end

@implementation AMTZoneMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModels.classCommand execute:@[(self.goods_class_id)]]subscribeNext:^(id x) {
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [[self.viewModels.listCommand execute:@[@"1",@"0",@"0",@"0",@(10),@(1)]]subscribeNext:^(id x) {
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : self.viewModels.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AMTBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTBannerCell identifier] forIndexPath:indexPath];
        cell.images =  @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png"];
        return cell;
    }
    AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = BHColor(@"f5f5f5");
    cell.model = self.viewModels.listArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    AMTHeadView *headView = [[AMTHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40) titleArray:@[@"全部",@"供货",@"求购"] click:^(NSInteger tag) {
        
    }];
    return section == 0 ? nil : headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0.01 : 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 188;
    }
    return [tableView cellHeightForIndexPath:indexPath model:self.viewModels.listArray[indexPath.row] keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN] +10;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit - 38) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTBannerCell class] forCellReuseIdentifier:[AMTBannerCell identifier]];
        [_tableView registerClass:[AMTGoodsMessageCell class] forCellReuseIdentifier:[AMTGoodsMessageCell identifier]];
    }
    return _tableView;
}

- (AMTHomeViewModel *)viewModels
{
    if (!_viewModels) {
        _viewModels = [[AMTHomeViewModel alloc]init];
    }
    return _viewModels;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
