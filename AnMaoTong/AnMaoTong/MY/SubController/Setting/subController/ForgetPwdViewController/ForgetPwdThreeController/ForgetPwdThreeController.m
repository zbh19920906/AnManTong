//
//  ForgetPwdThreeController.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdThreeController.h"

@interface ForgetPwdThreeController ()

@end

@implementation ForgetPwdThreeController

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
    kWeakObject(self)
    [[self.viewModel.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x){
        kStrongObject
        if ([weakSelf.viewModel.pwd1TextField.text isEqualToString:weakSelf.viewModel.pwd2TextField.text])
        {
            [weakSelf.dataModel.changePwdCommand execute:@[weakSelf.viewModel.pwd1TextField.text,weakSelf.viewModel.pwd2TextField.text]];
        }
        else
        {
            [UIView showInfoHUD:@"密码不一致" completeBlock:nil];
        }
    }];
    
    [self.dataModel.changePwdCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x){
        if ([x[0] boolValue])
        {
            [UIView showSuccessHUD:@"修改成功" completeBlock:^{
                kStrongObject
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    }];
}

#pragma mark - Public Method

#pragma mark - get
- (ForgetPwdThreeDataModel *)dataModel{
    if (_dataModel == nil)
        {
        _dataModel = [ForgetPwdThreeDataModel new];
    }
    return _dataModel;
}

- (ForgetPwdThreeViewModel *)viewModel{
    if (_viewModel == nil)
        {
        _viewModel = [ForgetPwdThreeViewModel new];
        _viewModel.dataModel = self.dataModel;
        _viewModel.viewController = self;
    }
    return _viewModel;
}

@end
