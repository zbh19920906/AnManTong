//
//  ForgetPwdOneViewModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/7.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdOneViewModel.h"
#import "ForgetPwdOneController.h"

@interface ForgetPwdOneViewModel ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *subTitleLab;
@property (nonatomic , strong) UILabel *phoneAreaLab;
@property (nonatomic , strong) UIView *line;
@end


@implementation ForgetPwdOneViewModel

#pragma mark - set
- (void)setCurrentTitle:(NSString *)currentTitle{
    self.titleLab.text = currentTitle;
}
#pragma mark - 生命周期

#pragma mark - Private Method
- (void)setupLayout:(UIView *)view{
    
    [view addSubview:self.titleLab];
    [view addSubview:self.subTitleLab];
    [view addSubview:self.phoneAreaLab];
    [view addSubview:self.phoneTextField];
    [view addSubview:self.line];
    [view addSubview:self.submitBtn];
    
    self.titleLab.sd_layout
    .topSpaceToView(view, 106)
    .leftSpaceToView(view, 24)
    .rightSpaceToView(view, 24)
    .autoHeightRatio(0);
    
    self.subTitleLab.sd_layout
    .topSpaceToView(self.titleLab, 30)
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .autoHeightRatio(0);
    
    self.phoneAreaLab.sd_layout
    .topSpaceToView(self.subTitleLab, 12)
    .leftEqualToView(self.titleLab)
    .autoHeightRatio(0);
    [self.phoneAreaLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.phoneTextField.sd_layout
    .topEqualToView(self.phoneAreaLab)
    .bottomEqualToView(self.phoneAreaLab)
    .leftSpaceToView(self.phoneAreaLab, 24)
    .rightEqualToView(self.titleLab);
    
    self.line.sd_layout
    .topSpaceToView(self.phoneAreaLab, 10)
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .heightIs(0.5);
    
    self.submitBtn.sd_layout
    .topSpaceToView(self.line, 24)
    .leftEqualToView(self.phoneAreaLab)
    .rightEqualToView(self.phoneTextField)
    .heightIs(52);
}

- (void)setupBingding{
    weakSelf(self);
    RAC(self.submitBtn,enabled) = [[self.phoneTextField rac_textSignal] map:^id _Nullable(NSString * _Nullable value){
        return @(value.length == 11);
    }];
    
    [[self.phoneTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x){
       
        [weakSelf.phoneTextField limitText:@"请输入正确手机号" number:11];
    }];
    
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x){
        weakSelf.dataModel.phone = weakSelf.phoneTextField.text;
        [weakSelf.dataModel.getCodeCommand execute:weakSelf.phoneTextField.text];
    }];
    
//    [self.dataModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x){
//
//        weakSelf.dataModel.phone = weakSelf.phoneTextField.text;
//        weakSelf.submitBtn.enabled = NO;
//        [weakSelf.dataModel.getCodeCommand execute:weakSelf.dataModel.phone];
//    }];
}

#pragma mark - Public Method
- (void)setupInitLayout{
    
//    self.viewController.navBar.hidden = YES;
//    self.viewController.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.viewController.navBar.rightButton setTitleColor:[UIColor cz_ToUIColorByStr:@"606270"] forState:UIControlStateNormal];
    self.viewController.navBar.rightButton.titleLabel.font = BHFont(16);
    [self.viewController.navBar.rightButton setTitle:@"1/3" forState:UIControlStateNormal];
    [self setupLayout:self.viewController.view];
    [self setupBingding];
}

#pragma mark - get
- (UILabel *)titleLab{
    if (_titleLab == nil)
        {
        _titleLab = [UILabel new];
        _titleLab.font = BHFont(20);
        _titleLab.textColor = [UIColor cz_ToUIColorByStr:@"333333"];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (_subTitleLab == nil)
        {
        _subTitleLab = [UILabel new];
        _subTitleLab.text = @"你的手机号";
        _subTitleLab.font = BHFont(12);
        _subTitleLab.textColor = [UIColor cz_ToUIColorByStr:@"6C727C"];
    }
    return _subTitleLab;
}

- (UILabel *)phoneAreaLab{
    if (_phoneAreaLab == nil)
        {
        _phoneAreaLab = [UILabel new];
        _phoneAreaLab.text = @"+86";
        _phoneAreaLab.font = BHFont(16);
        _phoneAreaLab.textColor = [UIColor cz_ToUIColorByStr:@"6C727C"];
    }
    return _phoneAreaLab;
}

- (BaseTextField *)phoneTextField{
    if (_phoneTextField == nil)
        {
        _phoneTextField = [BaseTextField new];
        NSDictionary *dic = @{NSForegroundColorAttributeName : [[UIColor cz_ToUIColorByStr:@"606270"] colorWithAlphaComponent:.2],
                              NSFontAttributeName : BHFont(16),
                              NSBaselineOffsetAttributeName : @(1)};
        _phoneTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"点击输入手机号" attributes:dic];
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

- (UIView *)line{
    if (_line == nil)
        {
        _line = [UIView new];
        _line.backgroundColor = BHLineColor();
    }
    return _line;
}

- (UIButton *)submitBtn{
    if (_submitBtn == nil)
        {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = BHFont(16);
        [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:imageNamed(@"WX20180108-170058") forState:UIControlStateNormal];
        [_submitBtn setSd_cornerRadius:@5];
    }
    return _submitBtn;
}


@end
