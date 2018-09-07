//
//  PersonalRadioView.m
//  yuexia
//
//  Created by 陈平 on 2018/1/14.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "PersonalRadioView.h"

@interface PersonalRadioView ()<
UIPickerViewDelegate,
UIPickerViewDataSource>
@property (nonatomic , strong) UIPickerView *pickView;
@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *sureBtn;
@property (nonatomic , assign) NSInteger currentIndex;
@end

@implementation PersonalRadioView

#pragma mark - set
- (void)setDataSource:(NSArray<NSString *> *)dataSource{
    _dataSource = dataSource;
    [self.pickView reloadAllComponents];
}

#pragma mark - Life
+(instancetype)radioViewWithTitle:(NSString *)title{
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds title:title];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self)
        {
        self.titleLab.text = title;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        [self setupInitForPersonalRadioView];
        [self setupBingdingForPersonalRadioView];
    }
    return self;
}

#pragma mark - Pravite
- (void)setupInitForPersonalRadioView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLab];
    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.sureBtn];
    [self.backView  addSubview:self.pickView];
    
    self.backView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, -318)
    .heightIs(274);
    
    self.titleLab.sd_layout
    .heightIs(44)
    .leftEqualToView(self.backView)
    .rightEqualToView(self.backView)
    .topEqualToView(self.backView);
    
    self.cancelBtn.sd_layout
    .heightIs(44)
    .widthEqualToHeight()
    .topEqualToView(self.backView)
    .leftSpaceToView(self.backView, 10);
    
    self.sureBtn.sd_layout
    .heightIs(44)
    .widthEqualToHeight()
    .topEqualToView(self.backView)
    .rightSpaceToView(self.backView, 10);
    
    self.pickView.sd_layout
    .topSpaceToView(self.titleLab, 0)
    .leftEqualToView(self.backView )
    .rightEqualToView(self.backView)
    .bottomEqualToView(self.backView);
    
    self.alpha = 0;
    [self.backView updateLayout];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.backView.sd_layout.bottomSpaceToView(self, 0);
        [self.backView updateLayout];
    }];
}

- (void)setupBingdingForPersonalRadioView{
    
}

#pragma mark - Public


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}

#pragma mark - UIPickerViewDelegate
//内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSource[row];
}

//选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.currentIndex = row;
}

#pragma mark - get
- (UILabel *)titleLab{
    if (_titleLab == nil)
        {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIButton *)sureBtn{
    if (_sureBtn == nil)
        {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = BHFont(14);
        [_sureBtn setTitleColor:[UIColor colorWithRed:0.38 green:0.60 blue:0.92 alpha:1.00] forState:UIControlStateNormal];
        weakSelf(self);
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
        {
            if (weakSelf.cpDelegate && [weakSelf.cpDelegate respondsToSelector:@selector(radioViewClick:)])
        {
                [weakSelf.cpDelegate radioViewClick:weakSelf.dataSource[weakSelf.currentIndex]];
            }
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.alpha = 0;
                weakSelf.backView.sd_layout.bottomSpaceToView(weakSelf,-318);
                [weakSelf.backView updateLayout];
            } completion:^(BOOL finished)
        {
                [weakSelf removeFromSuperview];
            }];
        }];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn == nil)
        {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = BHFont(14);
            weakSelf(self);
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x)
        {
            if (weakSelf.cpDelegate && [weakSelf.cpDelegate respondsToSelector:@selector(radioViewClickCancel)])
        {
                [weakSelf.cpDelegate radioViewClickCancel];
            }
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.alpha = 0;
                weakSelf.backView.sd_layout.bottomSpaceToView(weakSelf,-318);
                [weakSelf.backView updateLayout];
            } completion:^(BOOL finished)
        {
                [weakSelf removeFromSuperview];
            }];
        }];
    }
    return _cancelBtn;
}

- (UIView *)backView{
    if (_backView == nil)
        {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIPickerView *)pickView{
    if (_pickView == nil)
        {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectZero];
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}

@end
