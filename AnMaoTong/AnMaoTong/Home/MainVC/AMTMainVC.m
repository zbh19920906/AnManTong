//
//  AMTMainVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/4.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMainVC.h"
#import "AMTHomeViewModel.h"
#import "AMTBannerView.h"
#import "AMTZoneCell.h"
@interface AMTMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTHomeViewModel *viewModels;
@property (nonatomic, strong) AMTBannerView *bannerView;
@end

@implementation AMTMainVC

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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTZoneCell identifier] forIndexPath:indexPath];
    cell.zoneArray = self.viewModels.zoneArray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.bannerView = [[AMTBannerView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 188)];
         self.bannerView.images = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png"];
        return self.bannerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 188 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 10 + (ceil(self.viewModels.zoneArray.count * 1.0 / 2) * 95);
    }
    return 0;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTZoneCell class] forCellReuseIdentifier:[AMTZoneCell identifier]];
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
@end
