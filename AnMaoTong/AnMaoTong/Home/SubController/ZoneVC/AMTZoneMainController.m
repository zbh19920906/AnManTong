//
//  AMTMainVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/4.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTZoneMainController.h"
#import "AMTHomeViewModel.h"
#import "AMTBannerCell.h"
#import "AMTZoneCell.h"
#import "AMTHeadView.h"
#import "AMTDetailsVC.h"
#import "AMTZoneController.h"
#import "AMTMerchantDetalisController.h"
@interface AMTZoneMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTHomeViewModel *viewModels;
@property (nonatomic, strong) AMTDetailsModel *commentModel;
@property (nonatomic, strong) AMTHeadView *headView;
@property (nonatomic, assign) NSInteger requestIndex;
@end

@implementation AMTZoneMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.requestIndex = 0;
    self.page = 1;
    [self.view addSubview:self.tableView];
    [self setBingding];
}

- (void)removeNotifi
{
    [myNoti removeObserver:self];
}

- (void)setNotifi
{
    [myNoti addObserver:self selector:@selector(willChange:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)setBingding
{
    weakSelf(self);
    [self requestData];
    [[self.viewModels.classCommand execute:@[(self.goods_class_id)]]subscribeNext:^(id x) {
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    [[self.viewModels.bannerCommand execute:@[self.goods_class_id,@(AMTBannerTypeHome)]] subscribeNext:^(id x) {
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)setBrand_id:(NSString *)brand_id
{
    _brand_id = brand_id;
    self.page = 1;
    [self requestData];
}

- (void)requestData
{
    weakSelf(self);
    [[self.viewModels.listCommand execute:@[@(self.requestIndex),self.goods_class_id,self.brand_id,self.zone_id,@(self.page)]]subscribeNext:^(id x) {
        weakSelf.headView.hidden = NO;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)sendComment
{
    weakSelf(self);
    [[self.viewModels.commentCommand execute:@[self.commentModel,self.keyBoardInputView.inputTF.text]] subscribeNext:^(id x) {
        [weakSelf.keyBoardInputView hidden];
        [weakSelf.keyBoardInputView.inputTF resignFirstResponder];
        [weakSelf.tableView reloadData];
    }];
}

- (void)willChange:(NSNotification *)notifi
{
    NSValue *value = [notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [self.keyBoardInputView show:[value CGRectValue].size.height];
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
        cell.images =  self.viewModels.images;
        return cell;
    }
    AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = BHColor(@"f5f5f5");
    AMTDetailsModel *model = self.viewModels.listArray[indexPath.row];
    cell.model = model;
    
    weakSelf(self);
    [[[cell.headTap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        AMTMerchantDetalisController *vc = [[AMTMerchantDetalisController alloc]init];
        vc.user_id = model.user_business_id;
        vc.type = model.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [[[cell rac_signalForSelector:@selector(changeComment:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        weakSelf.commentModel = x[0];
        [weakSelf.keyBoardInputView.inputTF becomeFirstResponder];
    }];
    [[[cell rac_signalForSelector:@selector(changeCollection:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        AMTDetailsModel *model = x[0];
        [[weakSelf.viewModels.collectionCommand execute:model] subscribeNext:^(id x) {
            [weakSelf.tableView reloadData];
        }];
    }];
    [[[cell rac_signalForSelector:@selector(changeLike:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        AMTDetailsModel *model = x[0];
        [[weakSelf.viewModels.likeCommand execute:model] subscribeNext:^(id x) {
            [weakSelf.tableView reloadData];
        }];
    }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return section == 0 ? nil : self.headView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AMTDetailsVC *vc = [[AMTDetailsVC alloc]init];
        vc.dynamic_id = self.viewModels.listArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTZoneCell class] forCellReuseIdentifier:[AMTZoneCell identifier]];
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

- (AMTHeadView *)headView
{
    if (!_headView) {
        weakSelf(self);
        _headView = [[AMTHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40) titleArray:@[@"全部",@"供货",@"求购"] click:^(NSInteger tag) {
            weakSelf.requestIndex = tag;
            weakSelf.page = 1;
            [weakSelf requestData];
        }];
        _headView.hidden = YES;
    }
    return _headView;
}
@end
