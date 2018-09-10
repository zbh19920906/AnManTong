//
//  AMTLoginView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTLoginView.h"
@interface AMTLoginView ()

@end
@implementation AMTLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    weakSelf(self);
    BaseImageView *bgImage = [[BaseImageView alloc]initWithImage:imageNamed(@"Login_Bg")];
    
    BaseImageView *iconImage = [[BaseImageView alloc]initWithImage:imageNamed(@"Login_Logo")];
    
    
    self.phoneTF = [[BaseTextField alloc]init];
    self.phoneTF.sd_cornerRadius = @(23);
    self.phoneTF.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor cz_ToUIColorByStr:@"ffffff"]}];
    self.phoneTF.alpha = 0.5;
    [self.phoneTF setLableColor:@"FFFFFF" font:15 bold:0];
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTF.layer.borderColor = [[UIColor cz_ToUIColorByStr:@"FFFFFF"] CGColor];
    self.phoneTF.leftView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.layer.borderWidth = 1;
    
    self.codeTF = [[BaseTextField alloc]init];
    self.codeTF.sd_cornerRadius = @(23);
    self.codeTF.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor cz_ToUIColorByStr:@"ffffff"]}];
    [self.codeTF setLableColor:@"FFFFFF" font:15 bold:0];
    self.codeTF.alpha = 0.5;
    self.codeTF.secureTextEntry = YES;
    self.codeTF.leftView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.layer.borderColor = [[UIColor cz_ToUIColorByStr:@"FFFFFF"] CGColor];
    self.codeTF.layer.borderWidth = 1;
    
    BaseButton *forgetBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setLableColor:@"FEFEFF" font:12 bold:0];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [[forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(LoginClick:)]) {
            [weakSelf.delegate LoginClick:1];
        }
    }];
    
    BaseButton *loginBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setLableColor:@"FFFFFF" font:18 bold:0];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:imageNamed(@"Login_btn") forState:UIControlStateNormal];
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(LoginClick:)]) {
            [weakSelf.delegate LoginClick:2];
        }
    }];
    
    BaseButton *merchantsBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [merchantsBtn setLableColor:@"FFFFFF" font:15 bold:0];
    [merchantsBtn setTitle:@"商家注册" forState:UIControlStateNormal];
    [[merchantsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(LoginClick:)]) {
            [weakSelf.delegate LoginClick:4];
        }
    }];
    
    BaseView *linkView = [[BaseView alloc]init];
    linkView.backgroundColor = [UIColor cz_ToUIColorByStr:@"FFFFFF"];
    
    BaseButton *userBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [userBtn setLableColor:@"FFFFFF" font:15 bold:0];
    [userBtn setTitle:@"用户注册" forState:UIControlStateNormal];
    [[userBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(LoginClick:)]) {
            [weakSelf.delegate LoginClick:3];
        }
    }];
    [self sd_addSubviews:@[bgImage,iconImage,self.phoneTF,self.codeTF,forgetBtn,loginBtn,merchantsBtn,linkView,userBtn]];
    
    bgImage.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    iconImage.sd_layout
    .topSpaceToView(self, 128)
    .centerXEqualToView(self)
    .widthIs(109)
    .heightIs(38);
    
    self.phoneTF.sd_layout
    .topSpaceToView(iconImage, 77)
    .leftSpaceToView(self, 25)
    .rightSpaceToView(self, 25)
    .heightIs(45);
    
    self.codeTF.sd_layout
    .topSpaceToView(self.phoneTF, 20)
    .leftEqualToView(self.phoneTF)
    .rightEqualToView(self.phoneTF)
    .heightIs(45);
    
    forgetBtn.sd_layout
    .topSpaceToView(self.codeTF, 18)
    .leftSpaceToView(self, 29)
    .heightIs(12)
    .widthIs(70);
    
    loginBtn.sd_layout
    .topSpaceToView(self.codeTF, 48)
    .leftSpaceToView(self, 28)
    .rightSpaceToView(self, 27)
    .heightIs(45);
    
    linkView.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(loginBtn, 75)
    .widthIs(1)
    .heightIs(16);
    
    userBtn.sd_layout
    .centerYEqualToView(linkView)
    .rightSpaceToView(linkView, 30)
    .heightIs(16)
    .widthIs(65);
    
    merchantsBtn.sd_layout
    .centerYEqualToView(linkView)
    .leftSpaceToView(linkView, 30)
    .heightIs(16)
    .widthIs(65);
}
@end
