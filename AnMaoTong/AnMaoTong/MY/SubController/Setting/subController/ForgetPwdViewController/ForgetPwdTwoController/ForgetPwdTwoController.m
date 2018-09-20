//
//  ForgetPwdTwoController.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdTwoController.h"
#import "ForgetPwdThreeController.h"
@interface ForgetPwdTwoController ()

@end

@implementation ForgetPwdTwoController

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

    kWeakObject(self);
    [[self.viewModel.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
        {
        kStrongObject
            [[weakSelf.dataModel.loginCommand execute:@[weakSelf.dataModel.phone,weakSelf.viewModel.codeTextField.text]] subscribeNext:^(id x) {
                
                ForgetPwdThreeController *pwdVC = [ForgetPwdThreeController new];
                pwdVC.dataModel.code = weakSelf.viewModel.codeTextField.text;
                pwdVC.dataModel.phone = weakSelf.dataModel.phone;
                [weakSelf.navigationController pushViewController:pwdVC animated:YES];
            }];
    }];

}

#pragma mark - Public Method

#pragma mark - get
- (ForgetPwdTwoDataModel *)dataModel{
    if (_dataModel == nil)
        {
        _dataModel = [ForgetPwdTwoDataModel new];
    }
    return _dataModel;
}

- (ForgetPwdTwoViewModel *)viewModel{
    if (_viewModel == nil)
        {
        _viewModel = [ForgetPwdTwoViewModel new];
        _viewModel.dataModel = self.dataModel;
        _viewModel.viewController = self;
    }
    return _viewModel;
}
@end
