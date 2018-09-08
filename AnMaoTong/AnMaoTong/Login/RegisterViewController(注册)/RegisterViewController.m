//
//  RegisterViewController.m
//  yuexia
//
//  Created by 陈坚贞 on 2018/4/23.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewModel.h"
#import "LoginDataModel.h"
#import "AMTLoginVC.h"
#import "AMTUserNameViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.titieLab.text = self.type == RegisterUser ? @"用户注册" : @"商家注册";
    [KKNetWorking getShard].http_type = self.type == RegisterUser ? @"1" : @"2";
    self.navBar.titieLab.textColor = [UIColor cz_ToUIColorByStr:@"222222"];
    [self.navBar.backButton setImage:imageNamed(@"Register_close") forState:UIControlStateNormal];
    self.navBar.lineView.hidden = YES;
//    AMTUserNameViewController *vc = [AMTUserNameViewController new];
//    AMTRegisterModel *model = [[AMTRegisterModel alloc]init];
//    model.type = KKString(@(self.type));
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.registerViewModel setUpLayout];
    [self setBingDing];
}

#pragma mark - bingding
- (void)setBingDing
{
    weakSelf(self);
    //获取验证码
    [[self.registerViewModel.verifycodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (weakSelf.dataModel.isTimerOpen == NO)
        {
            [weakSelf.dataModel.getCodeCommand execute:weakSelf.registerViewModel.phoneTextField.text];
        }
    }];
    
    //获取验证码结果回调
    [self.dataModel.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x[0] boolValue]) {
            [UIView showSuccessHUD:@"获取成功" completeBlock:nil];
            if (weakSelf.dataModel.isTimerOpen == NO) {
                [weakSelf.dataModel startTimer];
            }
        }
    }];
    
    //监听倒计时
    [RACObserve(self.dataModel, codeTime) subscribeNext:^(id  _Nullable x) {
        NSString *str = @"获取验证码";
        if (weakSelf.dataModel.isTimerOpen) {
            str = [NSString stringWithFormat:@"%@ s", x];
        }
        [weakSelf.registerViewModel.verifycodeBtn setTitle:str forState:UIControlStateNormal];
    }];
    
    //监听是否可以获取验证码
    RAC(self.registerViewModel.verifycodeBtn, enabled) = [[self.registerViewModel.phoneTextField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 11);
    }];
    
    //监听是否可以登录或注册
//    RAC(self.registerViewModel.registerBtn,enabled) = [[[[self.registerViewModel.phoneTextField rac_textSignal]
//                                     merge:[self.registerViewModel.codeTextField rac_textSignal]]
//                                    merge:[self.registerViewModel.pswTextField rac_textSignal]]
//                                   map:^id _Nullable(id  _Nullable value){
//                                       return @([weakSelf getLogineType_loginForSubmitEnable]);
//                                   }];
    RAC(self.registerViewModel.registerBtn,backgroundColor) = [[[[self.registerViewModel.phoneTextField rac_textSignal]
                                                         merge:[self.registerViewModel.codeTextField rac_textSignal]]
                                                        merge:[self.registerViewModel.pswTextField rac_textSignal]]
                                                       map:^id _Nullable(id  _Nullable value){
                                                           if ([weakSelf getLogineType_loginForSubmitEnable]) {
                                                               weakSelf.registerViewModel.registerBtn.enabled = YES;
                                                               return BHColor(@"FF3658");
                                                           }else{
                                                               weakSelf.registerViewModel.registerBtn.enabled = NO;
                                                               return [UIColor cz_colorWithRed:243 green:178 blue:188];
                                                           }
                                                       }];
    [[self.registerViewModel.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSString *phone = weakSelf.registerViewModel.phoneTextField.text;
        NSString *code = weakSelf.registerViewModel.codeTextField.text;
        NSString *psd = weakSelf.registerViewModel.pswTextField.text;
        [weakSelf.dataModel.registerCommand execute:RACTuplePack(phone,code,psd,@(self.type))];
    }];
    
    //注册回调
    [self.dataModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x[0] boolValue])
        {
            [UIView showStatusHUD:@"注册成功" completeBlock:nil];
            AMTUserNameViewController *vc = [AMTUserNameViewController new];
            AMTRegisterModel *model = [[AMTRegisterModel alloc]init];
            model.type = KKString(@(self.type));
            vc.model = model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    

    [[self.registerViewModel.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (BOOL)getLogineType_loginForSubmitEnable
{
    return (self.registerViewModel.phoneTextField.text.length == 11 &&
            (self.registerViewModel.pswTextField.text.length >= 6 && self.registerViewModel.pswTextField.text.length <= 12));
}

#pragma mark -get
- (RegisterViewModel *)registerViewModel
{
    if (_registerViewModel == nil) {
        _registerViewModel = [RegisterViewModel new];
        _registerViewModel.viewController = self;
    }
    return _registerViewModel;
}

-(LoginDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [LoginDataModel new];
    }
    return _dataModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
