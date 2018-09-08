//
//  AMTMyLikeViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/8.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyLikeViewController.h"
#import "AMTMyLikeCell.h"
@interface AMTMyLikeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;

@end

@implementation AMTMyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.titieLab.text = @"我的评论";
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTMyLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTMyLikeCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 221;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN -NavHFit) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BHColor(@"ffffff");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[AMTMyLikeCell class] forCellReuseIdentifier:NSStringFromClass([AMTMyLikeCell class])];
        
    }
    return _tableView;
}

@end
