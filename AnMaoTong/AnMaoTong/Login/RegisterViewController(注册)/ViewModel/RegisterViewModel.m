//
//  RegisterViewModel.m
//  yuexia
//
//  Created by 陈坚贞 on 2018/4/25.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "RegisterViewModel.h"
#import "RegisterViewController.h"


@interface RegisterViewModel ()<
CPLinkLabViewDelegate>
@property (nonatomic, strong) UIImageView *registerLogoImgView;
@property (nonatomic, strong) UIView *codeBottomLine;

@end

@implementation RegisterViewModel

- (void)setUpLayout
{
    [self setUpInitLayout:self.viewController.view];
    [self setUpBingDing];
}

- (void)setUpInitLayout:(UIView *)view
{
    [view addSubview:self.registerLogoImgView];
    [view addSubview:self.phoneTextField];
    [view addSubview:self.codeTextField];
    [view addSubview:self.codeBottomLine];
    [view addSubview:self.pswTextField];
    [view addSubview:self.verifycodeBtn];
    [view addSubview:self.linkLab];
    [view addSubview:self.registerBtn];
    [view addSubview:self.loginBtn];
    
    
    self.registerLogoImgView.sd_layout
    .topSpaceToView(view, 37)
    .centerXEqualToView(view)
    .widthIs(169)
    .heightIs(90);
    
    
    self.phoneTextField.sd_layout
    .topSpaceToView(self.registerLogoImgView, 0)
    .leftSpaceToView(view, 33)
    .rightSpaceToView(view, 33)
    .heightIs(20);
    [self.phoneTextField addBottomLineWithOffset:-10 left:-5 right:-5 color:BHColor(@"E5E5E5") height:.5];
    
    
    self.codeTextField.sd_layout
    .topSpaceToView(self.phoneTextField, 45)
    .leftSpaceToView(view, 33)
    .rightSpaceToView(view, 135)
    .heightIs(20);
    
    
    self.codeBottomLine.sd_layout
    .topSpaceToView(self.codeTextField, 10)
    .leftSpaceToView(view, 28)
    .rightSpaceToView(view, 28)
    .heightIs(.5);
    
    
    self.pswTextField.sd_layout
    .topSpaceToView(self.codeTextField, 45)
    .leftSpaceToView(view, 33)
    .rightSpaceToView(view, 33)
    .heightIs(20);
    [self.pswTextField addBottomLineWithOffset:-10 left:0 right:0 color:BHColor(@"E5E5E5") height:.5];
    
    
    self.verifycodeBtn.sd_layout
    .centerYEqualToView(self.codeTextField)
    .rightSpaceToView(view, 35)
    .widthIs(90)
    .heightIs(40);
    
    
    self.linkLab.sd_layout
    .topSpaceToView(self.pswTextField, 20)
    .leftEqualToView(self.pswTextField)
    .rightEqualToView(view);
    
    
    self.registerBtn.sd_layout
    .topSpaceToView(self.linkLab, 14)
    .leftSpaceToView(view, 28)
    .rightSpaceToView(view, 28)
    .heightIs(45);
    [self.registerBtn setSd_cornerRadius:@25];
    
    
    self.loginBtn.sd_layout
    .bottomSpaceToView(view, 38)
    .centerXEqualToView(view)
    .widthIs(150)
    .heightIs(40);
    
    
}

#pragma mark - bingding
- (void)setUpBingDing
{
    weakSelf(self);
    [[self.phoneTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [weakSelf.phoneTextField limitText:@"请输入11位手机号码" number:11];
    }];
    
    [[self.codeTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [weakSelf.codeTextField limitText:@"请输入6位验证码" number:6];
    }];
    
    [[self.pswTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        [weakSelf.pswTextField limitText:@"请输入6-12位密码" number:12];
    }];
}

#pragma mark - CPLinkLabViewDelegate
- (void)linkLabViewClickLink:(CPLinkLabView *)linkLabView linkUrl:(NSString *)linkUrl
{
//    BaseWKWebViewController *webVC = [BaseWKWebViewController new];
//    webVC.urlStr = linkUrl;
//    webVC.title = @"约虾用户隐私条款";
//    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - get
-(UIImageView *)registerLogoImgView
{
    if (_registerLogoImgView == nil) {
        _registerLogoImgView = [UIImageView new];
        _registerLogoImgView.image = imageNamed(@"loginLogo");
    }
    return _registerLogoImgView;
}

-(BaseTextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [BaseTextField new];
        _phoneTextField.placeholder = KKString(@"请输入手机号码");
        _phoneTextField.textColor = BHColor(@"000000");
        _phoneTextField.font = BHFont(15);
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTextField;
}

-(BaseTextField *)codeTextField
{
    if (_codeTextField == nil) {
        _codeTextField = [BaseTextField new];
        _codeTextField.placeholder = KKString(@"请输入验证码");
        _codeTextField.textColor = BHColor(@"000000");
        _codeTextField.font = [UIFont systemFontOfSize:15];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _codeTextField;
}

-(UIView *)codeBottomLine
{
    if (_codeBottomLine == nil) {
        _codeBottomLine = [UIView new];
        _codeBottomLine.backgroundColor = BHColor(@"E5E5E5");
    }
    return _codeBottomLine;
}

-(BaseTextField *)pswTextField
{
    if (_pswTextField == nil) {
        _pswTextField = [BaseTextField new];
        _pswTextField.placeholder = KKString(@"请输入密码");
        _pswTextField.textColor = BHColor(@"000000");
        _pswTextField.font = [UIFont systemFontOfSize:15];
        _pswTextField.secureTextEntry = YES;
    }
    return _pswTextField;
}

-(UIButton *)verifycodeBtn
{
    if (_verifycodeBtn == nil) {
        _verifycodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifycodeBtn setTitle:KKString(@"获取验证码") forState:UIControlStateNormal];
        [_verifycodeBtn setTitleColor:BHColor(@"009CFF") forState:UIControlStateNormal];
        _verifycodeBtn.titleLabel.font = BHFont(14);
    }
    return _verifycodeBtn;
}

- (CPLinkLabView *)linkLab
{
    if (_linkLab == nil) {
        _linkLab = [CPLinkLabView linkLabView];
        [_linkLab addContent:@"注册代表您已阅读并同意《安贸通用户服务协议》"
               linkInContent:@"《安贸通用户服务协议》"
                      toLink:@"detail?id=116"];
        _linkLab.cpDeleagte = self;
        _linkLab.textInsets = UIEdgeInsetsZero;
    }
    return _linkLab;
}

-(UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitleColor:BHColor(@"FFFFFF") forState:UIControlStateNormal];
        [_registerBtn setTitle:KKString(@"注册") forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = BHFont(18);
        [_registerBtn setBackgroundColor:BHColor(@"fc3457")];
//        [_registerBtn setBackgroundImage:imageNamed(@"Register_btn") forState:UIControlStateNormal];
    }
    return _registerBtn;
}

-(UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"已有账号，立即登录"];
        [att addAttributes:@{NSFontAttributeName : BHFont(15) ,NSForegroundColorAttributeName : BHColor(@"222222")} range:[att.string rangeOfString:att.string]];
        [att addAttributes:@{NSFontAttributeName : BHFont(15) ,NSForegroundColorAttributeName : BHColor(@"FF3658")} range:[att.string rangeOfString:@"立即登录"]];
        [_loginBtn setAttributedTitle:att forState:UIControlStateNormal];
    }
    return _loginBtn;
}


@end
