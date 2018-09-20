//
//  ForgetPwdThreeViewModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdThreeViewModel.h"
#import "ForgetPwdThreeController.h"

@interface ForgetPwdThreeViewModel ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *sub1TitleLab;
@property (nonatomic , strong) UILabel *sub2TitleLab;
@property (nonatomic , strong) UIView *line1;
@property (nonatomic , strong) UIView *line2;
//@property (nonatomic , strong) UIBarButtonItem *rightItem;
@end


@implementation ForgetPwdThreeViewModel

#pragma mark - set

#pragma mark - 生命周期

#pragma mark - Private Method
- (void)setupLayout:(UIView *)view{
    [view addSubview:self.titleLab];
    [view addSubview:self.sub1TitleLab];
    [view addSubview:self.sub2TitleLab];
    [view addSubview:self.pwd1TextField];
    [view addSubview:self.pwd2TextField];
    [view addSubview:self.line1];
    [view addSubview:self.line2];
    [view addSubview:self.submitBtn];
    
    self.titleLab.sd_layout
    .topSpaceToView(view, 106)
    .leftSpaceToView(view, 24)
    .rightSpaceToView(view, 24)
    .autoHeightRatio(0);
    
    self.sub1TitleLab.sd_layout
    .topSpaceToView(self.titleLab, 30)
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .autoHeightRatio(0);
    
    self.pwd1TextField.sd_layout
    .leftEqualToView(self.sub1TitleLab)
    .rightEqualToView(self.sub1TitleLab)
    .heightIs(22)
    .topSpaceToView(self.sub1TitleLab, 10);
    
    self.line1.sd_layout
    .topSpaceToView(self.pwd1TextField, 5)
    .leftEqualToView(self.pwd1TextField)
    .rightEqualToView(self.pwd1TextField)
    .heightIs(0.5);
    
    self.sub2TitleLab.sd_layout
    .topSpaceToView(self.line1, 30)
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .autoHeightRatio(0);
    
    self.pwd2TextField.sd_layout
    .leftEqualToView(self.sub2TitleLab)
    .rightEqualToView(self.sub2TitleLab)
    .heightIs(22)
    .topSpaceToView(self.sub2TitleLab, 10);
    
    self.line2.sd_layout
    .topSpaceToView(self.pwd2TextField, 5)
    .leftEqualToView(self.pwd2TextField)
    .rightEqualToView(self.pwd2TextField)
    .heightIs(0.5);
    
    self.submitBtn.sd_layout
    .topSpaceToView(self.line2, 63)
    .leftEqualToView(self.line2)
    .rightEqualToView(self.line2)
    .heightIs(50);

}

- (void)setupBingding{
    
    weakSelf(self);
    RAC(self.submitBtn,enabled) = [[[self.pwd1TextField rac_textSignal] merge:[self.pwd2TextField rac_textSignal]] map:^id _Nullable(id  _Nullable value)
        {
        return @((weakSelf.pwd1TextField.text.length >= 6 && weakSelf.pwd1TextField.text.length <= 12) &&
                 (weakSelf.pwd2TextField.text.length >= 6 && weakSelf.pwd2TextField.text.length <= 12));
    }];
    
    [[self.pwd1TextField rac_textSignal] subscribeNext:^(NSString * _Nullable x)
        {
            [weakSelf.pwd1TextField limitText:@"请输入6-12位密码" number:12];
    }];
    
    [[self.pwd2TextField rac_textSignal] subscribeNext:^(NSString * _Nullable x)
        {
            [weakSelf.pwd2TextField limitText:@"请输入6-12位密码" number:12];
    }];
}

#pragma mark - Public Method
- (void)setupInitLayout{

//    [self.viewController hiddenNavgationBarBottomLine:YES alphaNavgationBar:YES];
    [self.viewController.navBar.rightButton setTitleColor:[UIColor cz_ToUIColorByStr:@"606270"] forState:UIControlStateNormal];
    self.viewController.navBar.rightButton.titleLabel.font = BHFont(16);
    [self.viewController.navBar.rightButton setTitle:@"3/3" forState:UIControlStateNormal];
    [self setupLayout:self.viewController.view];
    [self setupBingding];
//    self.viewController.navigationItem.rightBarButtonItem = self.rightItem;
}
#pragma mark - get
- (UILabel *)titleLab{
    if (_titleLab == nil)
        {
        _titleLab = [UILabel new];
        _titleLab.text = @"重置密码";
        _titleLab.font = BHFont(20);
        _titleLab.textColor = [UIColor cz_ToUIColorByStr:@"333333"];
    }
    return _titleLab;
}

- (UILabel *)sub1TitleLab{
    if (_sub1TitleLab == nil)
        {
        _sub1TitleLab = [UILabel new];
        _sub1TitleLab.text = @"新密码";
        _sub1TitleLab.textColor = [UIColor cz_ToUIColorByStr:@"6C727C"];
        _sub1TitleLab.font = BHFont(12);
    }
    return _sub1TitleLab;
}

- (UILabel *)sub2TitleLab{
    if (_sub2TitleLab == nil)
        {
        _sub2TitleLab = [UILabel new];
        _sub2TitleLab.text = @"确认密码";
        _sub2TitleLab.textColor = [UIColor cz_ToUIColorByStr:@"6C727C"];
        _sub2TitleLab.font = BHFont(12);
    }
    return _sub2TitleLab;
}

- (BaseTextField *)pwd1TextField{
    if (_pwd1TextField == nil)
        {
        _pwd1TextField = [BaseTextField new];
        NSDictionary *dic = @{NSForegroundColorAttributeName : [[UIColor cz_ToUIColorByStr:@"606270"] colorWithAlphaComponent:.2],
                              NSFontAttributeName : BHFont(16),
                              NSBaselineOffsetAttributeName : @(-1)};
        _pwd1TextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"点击输入新的密码" attributes:dic];
        _pwd1TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwd1TextField.keyboardType = UIKeyboardTypeASCIICapable;
        _pwd1TextField.secureTextEntry = YES;
    }
    return _pwd1TextField;
}

- (BaseTextField *)pwd2TextField{
    if (_pwd2TextField == nil)
        {
        _pwd2TextField = [BaseTextField new];
        NSDictionary *dic = @{NSForegroundColorAttributeName : [[UIColor cz_ToUIColorByStr:@"606270"] colorWithAlphaComponent:.2],
                              NSFontAttributeName : BHFont(16),
                              NSBaselineOffsetAttributeName : @(-1)};
        _pwd2TextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"再次输入新的密码" attributes:dic];
        _pwd2TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwd2TextField.keyboardType = UIKeyboardTypeASCIICapable;
        _pwd2TextField.secureTextEntry = YES;
    }
    return _pwd2TextField;
}

- (UIView *)line1{
    if (_line1 == nil)
        {
        _line1 = [UIView new];
        _line1.backgroundColor = BHLineColor();
    }
    return _line1;
}

- (UIView *)line2{
    if (_line2 == nil)
        {
        _line2 = [UIView new];
        _line2.backgroundColor = BHLineColor();
    }
    return _line2;
}

//- (UIBarButtonItem *)rightItem{
//    if (_rightItem == nil)
//        {
//        _rightItem = [UIBarButtonItem barButton:@"3/3" isSizeToFit:YES button:^(UIButton *btn)
//        {
//            
//        }];
//    }
//    return _rightItem;
//}

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
