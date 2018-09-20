//
//  AMTDetailsVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsVC.h"
#import "AMTCommentListCell.h"
#import "AMTGoodsMessageCell.h"
#import "AMTDetailsViewModel.h"
@interface AMTDetailsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) BaseLabel *commentCountLab;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTDetailsViewModel *viewModels;
@end

@implementation AMTDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = @"详情";
    [self.view addSubview:self.tableView];
    [self setBingDing];
}

- (void)setBingDing
{
    weakSelf(self);
    [[self.viewModels.detailsCommand execute:@[self.dynamic_id]] subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
    [[self.viewModels.listCommand execute:@[self.dynamic_id,@"1"]] subscribeNext:^(id x) {
        
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    [myNoti addObserver:self selector:@selector(willChange:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)sendComment
{
    weakSelf(self);
    [[self.viewModels.commentCommand execute:@[self.keyBoardInputView.inputTF.text]] subscribeNext:^(id x) {
        [weakSelf.keyBoardInputView hidden];
        [weakSelf.keyBoardInputView.inputTF resignFirstResponder];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
        AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTGoodsMessageCell class]) forIndexPath:indexPath];
        cell.model = self.viewModels.model;
        weakSelf(self);
        [[[cell rac_signalForSelector:@selector(changeComment:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            [weakSelf.keyBoardInputView.inputTF becomeFirstResponder];
        }];
        [[[cell rac_signalForSelector:@selector(changeCollection:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            [[weakSelf.viewModels.collectionCommand execute:nil] subscribeNext:^(id x) {
                [weakSelf.tableView reloadData];
            }];
        }];
        [[[cell rac_signalForSelector:@selector(changeLike:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            [[weakSelf.viewModels.likeCommand execute:nil] subscribeNext:^(id x) {
                [weakSelf.tableView reloadData];
            }];
        }];
        return cell;
    }
    AMTCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTCommentListCell class]) forIndexPath:indexPath];
    cell.model = self.viewModels.listArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? [tableView cellHeightForIndexPath:indexPath model:self.viewModels.model keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN] : [tableView cellHeightForIndexPath:indexPath model:self.viewModels.listArray[indexPath.row] keyPath:@"model" cellClass:[AMTCommentListCell class] contentViewWidth:WIDTH_SCREEN];;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        BaseView *headView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 44)];
        headView.backgroundColor = [UIColor whiteColor];
        self.commentCountLab = [[BaseLabel alloc]initWithFrame:CGRectMake(12, 20, 200, 12)];
        [self.commentCountLab setLableColor:@"222222" font:12 bold:0];
        self.commentCountLab.text = [NSString stringWithFormat:@"最新评论(%ld)",self.viewModels.listArray.count];
        [headView addSubview:self.commentCountLab];
        
        return headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0.01 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 10 : 0.01;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTGoodsMessageCell class] forCellReuseIdentifier:NSStringFromClass([AMTGoodsMessageCell class])];
        [_tableView registerClass:[AMTCommentListCell class] forCellReuseIdentifier:NSStringFromClass([AMTCommentListCell class])];
        
    }
    return _tableView;
}

- (AMTDetailsViewModel *)viewModels
{
    if (!_viewModels) {
        _viewModels = [[AMTDetailsViewModel alloc]init];
    }
    return _viewModels;
}
@end
