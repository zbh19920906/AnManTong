//
//  AMTFindSubVIewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFindSubVIewController.h"
#import "AMTFindViewModel.h"
#import "AMTFindHeadView.h"
#import "AMTMyCollectionCell.h"
#import "AMTFocusShopCell.h"
@interface AMTFindSubVIewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AMTFindViewModel *viewModels;
@property (nonatomic, copy) NSArray <AMTBrandModel *> *brandArray;
@property (nonatomic, copy) NSArray <AMTBannerModel *> *bannerArray;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTFindHeadView *headView;
@property (nonatomic, assign) NSInteger dynamicPage;
@end

@implementation AMTFindSubVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dynamicPage = 1;
    [self setBingding];
}

- (void)setIsGoods:(BOOL)isGoods
{
    _isGoods = isGoods;
    weakSelf(self);
    [[self.viewModels.bannerCommand execute:@[self.goods_class_id,@(self.isGoods ? AMTBannerTypeFindUser : AMTBannerTypeFindMerchants)]] subscribeNext:^(id x) {
        weakSelf.bannerArray = x[0];
        weakSelf.headView.images = weakSelf.bannerArray;
    }];
    [self.tableView reloadData];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModels.brandCommand execute:@[self.goods_class_id]] subscribeNext:^(id x) {
        weakSelf.brandArray = x[0];
        weakSelf.headView.brands = weakSelf.brandArray;
    }];
    [[self.viewModels.bannerCommand execute:@[self.goods_class_id,@(self.isGoods ? AMTBannerTypeFindUser : AMTBannerTypeFindMerchants)]] subscribeNext:^(id x) {
        weakSelf.bannerArray = x[0];
        weakSelf.headView.images = weakSelf.bannerArray;
    }];
    [[self.viewModels.businessCommand execute:@[@(self.page),self.goods_class_id,@""]] subscribeNext:^(id x) {
        weakSelf.page += 1;
        [weakSelf.tableView reloadData];
    }];
    [[self.viewModels.dynamicCommand execute:@[@(self.dynamicPage),self.goods_class_id,@""]] subscribeNext:^(id x) {
        weakSelf.dynamicPage += 1;
    }];
}

- (void)requestData
{
    weakSelf(self);
    if (self.isGoods) {
        [[self.viewModels.dynamicCommand execute:@[@(self.dynamicPage),self.goods_class_id,@""]] subscribeNext:^(id x) {
            weakSelf.dynamicPage += 1;
            [weakSelf endRefresh];
            [weakSelf.tableView reloadData];
        }];
    }else{
        [[self.viewModels.businessCommand execute:@[@(self.page),self.goods_class_id,@""]] subscribeNext:^(id x) {
            weakSelf.page += 1;
            [weakSelf endRefresh];
            [weakSelf.tableView reloadData];
        }];
    }
}

- (void)loadNewData
{
    if (self.isGoods) {
        self.dynamicPage = 1;
    }else{
        self.page = 1;
    }
    [self requestData];
}

- (void)loadMoreToData
{
    [self requestData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isGoods ? self.viewModels.dynamicArray.count : self.viewModels.businessArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isGoods){
        AMTMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTMyCollectionCell class]) forIndexPath:indexPath];
        cell.isHistory = NO;
        cell.model = self.viewModels.dynamicArray[indexPath.row];
        return cell;
    }else{
        AMTFocusShopCell*cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTFocusShopCell class]) forIndexPath:indexPath];
        cell.model = self.viewModels.businessArray[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isGoods ? 136 : 76;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return self.bannerArray.count <= 5 ? 188 + 88 : 369;
    return 369;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit - TabBarHFit - 38) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.mj_header = self.header;
        _tableView.mj_footer = self.footer;
        [_tableView registerClass:[AMTMyCollectionCell class] forCellReuseIdentifier:[AMTMyCollectionCell identifier]];
        [_tableView registerClass:[AMTFocusShopCell class] forCellReuseIdentifier:[AMTFocusShopCell identifier]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (AMTFindHeadView *)headView
{
    if (!_headView) {
        _headView = [[AMTFindHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 188)];
    }
    return _headView;
}

- (AMTFindViewModel *)viewModels
{
    if (!_viewModels) {
        _viewModels = [[AMTFindViewModel alloc]init];
    }
    return _viewModels;
}
@end
