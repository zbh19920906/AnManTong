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
#import "AMTSettingController.h"
#import "AMTMyVIewModel.h"
@interface AMTMyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AMTMyHeadView *headView;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTMyVIewModel *viewModel;
@end

@implementation AMTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;
    
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
    [[self.viewModel.setCountCommand execute:nil] subscribeNext:^(id x) {
       weakSelf.headView.model = weakSelf.viewModel.model;
    }];
    
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
    return self.viewModel.model.iconArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.viewModel.model.iconArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = imageNamed(self.viewModel.model.iconArr[indexPath.section][indexPath.row]);
    cell.textLabel.text = self.viewModel.model.titleArr[indexPath.section][indexPath.row];
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
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = @"A15160454910";
                ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"复制成功\n请前往微信添加对方" message:@""];
                [alertView addBtnTitle:@"前往" action:^{
                    NSURL *url = [NSURL URLWithString:@"weixin://"];
                    [[UIApplication sharedApplication] openURL:url];
                }];
                [alertView showAlertWithSender:self];
            }
                break;
            case 1:
            {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = @"2751588294";
                ZLAlertView *alertView = [[ZLAlertView alloc]initWithTitle:@"复制成功\n请前往QQ添加对方" message:@""];
                [alertView addBtnTitle:@"前往" action:^{
                    
                    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"2751588294"]];
                     [[UIApplication sharedApplication] openURL:url];
                    
                }];
                [alertView showAlertWithSender:self];
            }
                break;
            case 2:
            {
               
            }
                break;
                
            case 3:
            {
                //设置
                AMTSettingController *vc = [[AMTSettingController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
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

- (AMTMyVIewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTMyVIewModel alloc]init];
    }
    return _viewModel;
}
@end
