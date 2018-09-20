//
//  ForgetPwdOneController.m
//  yuexia
//
//  Created by 陈平 on 2017/12/7.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdOneController.h"
#import "ForgetPwdTwoController.h"


@interface ForgetPwdOneController ()

@end

@implementation ForgetPwdOneController

#pragma mark - set

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInit];
    [self setupBingding];
}

#pragma mark - Private Method
- (void)setupInit{
    [self.viewModel setupInitLayout];
}

- (void)setupBingding{
    
    weakSelf(self);
    //获取验证码回调监听
    [self.dataModel.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x){
       
        if ([x[0] boolValue])
        {
            [UIView showSuccessHUD:@"验证码获取成功" completeBlock:^{
                weakSelf.viewModel.submitBtn.enabled = YES;
                ForgetPwdTwoController *pwdVC = [ForgetPwdTwoController new];
                pwdVC.dataModel.phone = weakSelf.dataModel.phone;
                [weakSelf.navigationController pushViewController:pwdVC animated:YES];
            }];
        }
        else
        {
            weakSelf.viewModel.submitBtn.enabled = YES;
        }
    }];
    
}

#pragma mark - Public Method

#pragma mark - get
- (ForgetPwdOneViewModel *)viewModel{
    if (_viewModel == nil)
    {
        _viewModel = [ForgetPwdOneViewModel new];
        _viewModel.viewController = self;
        _viewModel.dataModel = self.dataModel;
    }
    return _viewModel;
}

- (ForgetPwdOneDataModel *)dataModel{
    if (_dataModel == nil)
    {
        _dataModel = [ForgetPwdOneDataModel new];
    }
    return _dataModel;
}
@end

