//
//  AMTMessageVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/8/30.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMessageVC.h"
#import "AMTMessageHeadView.h"
@interface AMTMessageVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTMessageHeadView *headView;
@end

@implementation AMTMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    [self.view sd_addSubviews:@[self.tableView,self.headView]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 3 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 120, WIDTH_SCREEN, HEIGHT_SCREEN - 120 - TabBarHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.clipsToBounds = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (AMTMessageHeadView *)headView
{
    if (!_headView) {
        _headView = [[AMTMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 120)];
    }
    return _headView;
}
@end
