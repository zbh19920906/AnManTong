//
//  AMTScreenTitleView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTScreenTitleView.h"
#import "AMTScreenTitleCell.h"
@interface AMTScreenTitleView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTScreenTitleCell *oldCell;
@end
@implementation AMTScreenTitleView

- (instancetype)initWithFrame:(CGRect)frame changeItemBlock:(ChangeItemBlock)changeItemBlock
{
    if (self = [super initWithFrame:frame]) {
        self.changeItemBlock = changeItemBlock;
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTScreenTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AMTGoodsClassModel *model = _titles[indexPath.row];
    [cell.button setTitle:model.name forState:UIControlStateNormal];
    if (indexPath.row == 0) {
        cell.button.selected = YES;
        cell.button.backgroundColor = [UIColor whiteColor];
        _oldCell = cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AMTScreenTitleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _oldCell.button.selected = NO;
    _oldCell.button.backgroundColor = [UIColor cz_ToUIColorByStr:@"f5f5f5"];
    cell.button.selected = YES;
    cell.button.backgroundColor = [UIColor whiteColor];
    _oldCell = cell;
    self.changeItemBlock(_titles[indexPath.row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = [UIColor cz_ToUIColorByStr:@"f5f5f5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AMTScreenTitleCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
@end
