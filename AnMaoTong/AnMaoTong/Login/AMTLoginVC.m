//
//  AMTLoginVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTLoginVC.h"
#import "AMTLoginView.h"
#import "LoginDataModel.h"
#import "RegisterViewController.h"
@interface AMTLoginVC ()<AMTLoginViewDelegate>
@property (nonatomic , strong) LoginDataModel *dataModel;
@property (nonatomic, strong) AMTLoginView *loginView;
@end

@implementation AMTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = @"登录";
    self.navBar.backgroundColor = [UIColor clearColor];
    self.navBar.backButton.hidden = NO;
    [self.navBar.backButton setImage:imageNamed(@"Login_close") forState:UIControlStateNormal];
    
    self.navBar.titieLab.textColor = [UIColor cz_ToUIColorByStr:@"FFFFFF"];
    self.navBar.lineView.hidden = YES;
    _loginView = [[AMTLoginView alloc]initWithFrame:self.view.bounds];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    [self change];
}

- (void)change
{
    weakSelf(self);
    [[self.navBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.dataModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x[0] boolValue]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (void)LoginClick:(NSInteger)tag
{
    switch (tag) {
        case 1:
        {
            //忘记密码
        }
            break;
        case 2:
        {
            //登录
            [self.dataModel.loginCommand execute:RACTuplePack(self.loginView.phoneTF.text,self.loginView.codeTF.text)];
        }
            break;
        case 3:
        {
            //用户注册
            RegisterViewController *vc= [RegisterViewController new];
            vc.type = RegisterUser;
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
            break;
        case 4:
        {
            //商家注册
            RegisterViewController *vc= [RegisterViewController new];
            vc.type = RegisterMerchants;
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(LoginDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [LoginDataModel new];
    }
    return _dataModel;
}
@end
