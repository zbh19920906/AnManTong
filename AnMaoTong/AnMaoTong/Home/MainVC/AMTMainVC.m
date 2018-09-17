//
//  AMTMainVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/4.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMainVC.h"
#import "AMTHomeViewModel.h"
#import "AMTBannerCell.h"
#import "AMTZoneCell.h"
#import "AMTHeadView.h"
#import "AMTDetailsVC.h"
#import "AMTMerchantDetalisController.h"
@interface AMTMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTHomeViewModel *viewModels;
@property (nonatomic, strong) AMTDetailsModel *commentModel;
@end

@implementation AMTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
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
    
    [myNoti addObserver:self selector:@selector(comment:) name:commentNoti object:nil];
    [myNoti addObserver:self selector:@selector(sendComment) name:sendCommentNoti object:nil];
    [myNoti addObserver:self selector:@selector(collection:) name:collectionNoti object:nil];
    [myNoti addObserver:self selector:@selector(like:) name:likeNoti object:nil];
    [myNoti addObserver:self selector:@selector(willChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)comment:(NSNotification *)notifi
{
    self.commentModel = notifi.userInfo[@"model"];
    [self.keyBoardInputView.inputTF becomeFirstResponder];
}

- (void)sendComment
{
    [[self.viewModels.commentCommand execute:@[self.commentModel,self.keyBoardInputView.inputTF.text]] subscribeNext:^(id x) {
                    [self.keyBoardInputView.inputTF resignFirstResponder];
                    [self.tableView reloadData];
    }];
}

- (void)collection:(NSNotification *)notifi
{
    AMTDetailsModel *model = notifi.userInfo[@"model"];
    [[self.viewModels.collectionCommand execute:model] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)like:(NSNotification *)notifi
{
    AMTDetailsModel *model = notifi.userInfo[@"model"];
    [[self.viewModels.likeCommand execute:model] subscribeNext:^(id x) {
        [self.tableView reloadData];
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
    return section == 0 ? 2 : self.viewModels.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AMTBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTBannerCell identifier] forIndexPath:indexPath];
            cell.images =  @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png"];
            return cell;
        }
        
        AMTZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTZoneCell identifier] forIndexPath:indexPath];
        cell.zoneArray = self.viewModels.zoneArray;
        return cell;
    }
    AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
    weakSelf(self);
    [[cell.headTap rac_gestureSignal]subscribeNext:^(id x) {
        AMTMerchantDetalisController *vc = [[AMTMerchantDetalisController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
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
        return indexPath.row == 0 ? 188 : 10 + (ceil(self.viewModels.zoneArray.count * 1.0 / 2) * 95);
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
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit - 38 - TabBarHFit) style:UITableViewStylePlain];
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
@end
