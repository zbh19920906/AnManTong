//
//  AMTMainVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/4.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMainVC.h"

@interface AMTMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@end

@implementation AMTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
@end
