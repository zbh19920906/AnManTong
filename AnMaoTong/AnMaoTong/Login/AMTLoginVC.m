//
//  AMTLoginVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTLoginVC.h"
#import "AMTLoginView.h"
#import "RegisterViewController.h"
@interface AMTLoginVC ()<AMTLoginViewDelegate>

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
    AMTLoginView *loginView = [[AMTLoginView alloc]initWithFrame:self.view.bounds];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    weakSelf(self);
    [[self.navBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
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
@end
