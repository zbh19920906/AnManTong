//
//  ForgetPwdTwoViewModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdTwoViewModel.h"
#import "ForgetPwdTwoController.h"

@interface ForgetPwdTwoViewModel ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *subTitleLab;
@property (nonatomic , strong) UILabel *codeLab;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIBarButtonItem *rightItem;
@end


@implementation ForgetPwdTwoViewModel

#pragma mark - set

#pragma mark - 生命周期

#pragma mark - Private Method
- (void)setupLayout:(UIView *)view{

    [view addSubview:self.titleLab];
    [view addSubview:self.subTitleLab];
    [view addSubview:self.codeLab];
    [view addSubview:self.codeTextField];
    [view addSubview:self.line];
    [view addSubview:self.submitBtn];
    
    self.titleLab.sd_layout
    .topSpaceToView(view, 106)
    .leftSpaceToView(view, 24)
    .rightSpaceToView(view, 24)
    .autoHeightRatio(0);
    
    self.subTitleLab.sd_layout
    .topSpaceToView(self.titleLab, 3)
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .autoHeightRatio(0);
    
    self.codeLab.sd_layout
    .topSpaceToView(self.subTitleLab, 30)
    .leftEqualToView(self.subTitleLab)
    .rightEqualToView(self.subTitleLab)
    .autoHeightRatio(0);
    
    self.codeTextField.sd_layout
    .topSpaceToView(self.codeLab, 15)
    .leftEqualToView(self.codeLab)
    .rightEqualToView(self.codeLab)
    .heightIs(24);
    
    self.line.sd_layout
    .topSpaceToView(self.codeTextField,5)
    .leftEqualToView(self.codeTextField)
    .rightEqualToView(self.codeTextField)
    .heightIs(0.5);
    
    self.submitBtn.sd_layout
    .topSpaceToView(self.line, 24)
    .leftEqualToView(self.line)
    .rightEqualToView(self.line)
    .heightIs(50);
    
}

- (void)setupBingding{
    kWeakObject(self)
    RAC(self.submitBtn,enabled) = [[self.codeTextField rac_textSignal] map:^id _Nullable(NSString * _Nullable value)
        {
        return @(value.length == 6);
    }];
    
    [[self.codeTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x)
        {
        kStrongObject
            [weakSelf.codeTextField limitText:@"请输入正确验证码" number:6];
    }];
}

#pragma mark - Public Method
- (void)setupInitLayout{

//    [self.viewController hiddenNavgationBarBottomLine:YES alphaNavgationBar:YES];
    [self.viewController.navBar.rightButton setTitleColor:[UIColor cz_ToUIColorByStr:@"606270"] forState:UIControlStateNormal];
    self.viewController.navBar.rightButton.titleLabel.font = BHFont(16);
    [self.viewController.navBar.rightButton setTitle:@"2/3" forState:UIControlStateNormal];
    [self setupLayout:self.viewController.view];
    [self setupBingding];
//    self.viewController.navigationItem.rightBarButtonItem = self.rightItem;
}

#pragma mark - get
- (UILabel *)titleLab{
    if (_titleLab == nil)
        {
        _titleLab = [UILabel new];
        _titleLab.text = @"我们发送了6位验证码至";
        _titleLab.font = BHFont(20);
        _titleLab.textColor = [UIColor cz_ToUIColorByStr:@"333333"];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (_subTitleLab == nil)
        {
        _subTitleLab = [UILabel new];
        NSMutableString *phone = [self.dataModel.phone mutableCopy];
        [phone insertString:@" " atIndex:phone.length - 4];
        [phone insertString:@" " atIndex:3];
        _subTitleLab.text = [NSString stringWithFormat:@"+86 %@",phone];
        _subTitleLab.textColor = [UIColor cz_ToUIColorByStr:@"6C727C"];
        _subTitleLab.font = BHFont(12);
    }
    return _subTitleLab;
}

- (UILabel *)codeLab{
    if (_codeLab == nil)
        {
        _codeLab = [UILabel new];
        _codeLab.text = @"请输入短信验证码";
        _codeLab.textColor = [UIColor cz_ToUIColorByStr:@"0B78E3"];
        _codeLab.font = BHFont(12);
    }
    return _codeLab;
}

- (BaseTextField *)codeTextField{
    if (_codeTextField == nil)
        {
        _codeTextField = [BaseTextField new];
        NSDictionary *dic = @{NSForegroundColorAttributeName : [[UIColor cz_ToUIColorByStr:@"606270"] colorWithAlphaComponent:.2],
                              NSFontAttributeName : BHFont(16),
                              NSBaselineOffsetAttributeName : @(-1)};
        _codeTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"点击输入验证码" attributes:dic];
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTextField;
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

//- (UIBarButtonItem *)rightItem{
//    if (_rightItem == nil)
//        {
//        _rightItem = [UIBarButtonItem barButton:@"2/3" isSizeToFit:YES button:^(UIButton *btn)
//        {
//            [btn setTitleColor:[UIColor cz_ToUIColorByStr:@"606270"] forState:UIControlStateNormal];
//            btn.titleLabel.font = CPFont_Regular(16);
//        }];
//    }
//    return _rightItem;
//}

@end
