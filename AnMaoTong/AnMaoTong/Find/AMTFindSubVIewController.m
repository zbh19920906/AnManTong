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
@interface AMTFindSubVIewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AMTFindViewModel *viewModels;
@property (nonatomic, copy) NSArray <AMTBrandModel *> *brandArray;
@property (nonatomic, copy) NSArray <AMTBannerModel *> *bannerArray;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTFindHeadView *headView;

@end

@implementation AMTFindSubVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [[self.viewModels.brandCommand execute:@[self.goods_class_id]] subscribeNext:^(id x) {
        weakSelf.brandArray = x[0];
    }];
    [[self.viewModels.bannerCommand execute:@[self.goods_class_id]] subscribeNext:^(id x) {
        weakSelf.bannerArray = x[0];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell identifier] forIndexPath:indexPath];
    
    return cell;
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

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:[BaseTableViewCell identifier]];
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
