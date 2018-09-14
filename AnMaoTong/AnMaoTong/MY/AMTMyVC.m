//
//  AMTMyVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/8/30.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyVC.h"
#import "AMTMyHeadView.h"
#import "AMTPersonalViewController.h"
#import "AMTFocusViewController.h"
#import "AMTMyCollectionViewController.h"
#import "AMTMyCommentsViewController.h"
#import "AMTMyLikeViewController.h"
@interface AMTMyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AMTMyHeadView *headView;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTMyModel *model;
@end

@implementation AMTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    self.headView.model = self.model;
    [self.view addSubview:self.tableView];
    [self event];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.headView changeUI];
}

- (void)event
{
    weakSelf(self);
    [[myNoti rac_addObserverForName:goMyItemNoti object:nil]subscribeNext:^(id x) {
        NSNotification *notifi = x;
        NSInteger tag = [notifi.userInfo[@"tag"] integerValue];
        switch (tag) {
            case 1:
                {
                    
                }
                break;
            case 2:
            {
                AMTFocusViewController *vc = [[AMTFocusViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                AMTMyCollectionViewController *vc =[[AMTMyCollectionViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.iconArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.model.iconArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = imageNamed(self.model.iconArr[indexPath.section][indexPath.row]);
    cell.textLabel.text = self.model.titleArr[indexPath.section][indexPath.row];
    [cell.textLabel setLableColor:@"222222" font:14 bold:0];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                AMTMyCommentsViewController *vc = [[AMTMyCommentsViewController alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                AMTMyLikeViewController *vc = [[AMTMyLikeViewController alloc]init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                AMTMyCollectionViewController *vc = [[AMTMyCollectionViewController alloc]init];
                vc.isHistory = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
                
            default:
                break;
        }
    }else{
        
    }
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - TabBarHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (AMTMyHeadView *)headView
{
    if (!_headView) {
        _headView = [[AMTMyHeadView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 318)];
        weakSelf(self);
        [[_headView.changeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            AMTPersonalViewController *vc = [[AMTPersonalViewController alloc]init];
            vc.isUser = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headView;
}

- (AMTMyModel *)model
{
    if (!_model) {
        _model = [[AMTMyModel alloc]init];
    }
    return _model;
}
@end
