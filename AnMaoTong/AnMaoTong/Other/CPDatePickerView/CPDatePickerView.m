//
//  CPDatePickerView.m
//  yuexia
//
//  Created by 陈平 on 2018/1/14.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "CPDatePickerView.h"

@interface CPDatePickerView ()
@property (nonatomic , strong) UIDatePicker *datePicker;
@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *sureBtn;
@end

@implementation CPDatePickerView

#pragma mark - Life
+(instancetype)datePickerViewWithTitle:(NSString *)title{
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds title:title];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self)
        {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
        self.titleLab.text = @"出生日期";
        [self setupInitForCPDatePickerView];
        [self setupBingdingForCPDatePickerView];
        
        
    }
    return self;
}

#pragma mark - Pravite
- (void)setupInitForCPDatePickerView{
    [self addSubview:self.datePicker];
    [self addSubview:self.titleView];
    [self.titleView addSubview:self.cancelBtn];
    [self.titleView addSubview:self.sureBtn];
    [self.titleView addSubview:self.titleLab];
    
    self.datePicker.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, -274)
    .heightIs(230);
    
    self.titleView.sd_layout
    .bottomSpaceToView(self.datePicker, 0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(44);
    
    self.titleLab.sd_layout
    .centerXEqualToView(self.titleView)
    .centerYEqualToView(self.titleView)
    .autoHeightRatio(0);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.cancelBtn.sd_layout
    .leftSpaceToView(self.titleView, 10)
    .topEqualToView(self.titleView)
    .bottomEqualToView(self.titleView)
    .widthEqualToHeight();
    
    self.sureBtn.sd_layout
    .rightSpaceToView(self.titleView, 10)
    .topEqualToView(self.cancelBtn)
    .bottomEqualToView(self.cancelBtn)
    .widthEqualToHeight();
    

    self.alpha = 0;
    [self.datePicker updateLayout];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.datePicker.sd_layout.bottomSpaceToView(self, 0);
        [self.datePicker updateLayout];
    }];
}

- (void)setupBingdingForCPDatePickerView{
    
}

#pragma mark - Public
- (void)showTime:(NSString *)time{
    
    if (!time.length)
        {
        return;
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *defultDate =[dateFormat dateFromString:time];
    [self.datePicker setDate:defultDate];
}

#pragma mark - get
- (UIDatePicker *)datePicker{
    if (_datePicker == nil)
        {
        _datePicker = [[UIDatePicker alloc] initWithFrame:self.bounds];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY/MM/DD";
        _datePicker.minimumDate = [formatter dateFromString:@"1900/1/1"];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:-18];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        _datePicker.maximumDate = maxDate;
    
    }
    return _datePicker;
}

- (UILabel *)titleLab{
    if (_titleLab == nil)
        {
        _titleLab = [UILabel new];
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
            NSDate *theDate = weakSelf.datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"YYYY-MM-dd";
            if (weakSelf.cpDelegate && [weakSelf.cpDelegate respondsToSelector:@selector(pickerViewForClick:)])
        {
                [weakSelf.cpDelegate pickerViewForClick:[dateFormatter stringFromDate:theDate]];
            }
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.alpha = 0;
                weakSelf.datePicker.sd_layout.bottomSpaceToView(weakSelf,-274);
                [weakSelf.datePicker updateLayout];
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
            if (weakSelf.cpDelegate && [weakSelf.cpDelegate respondsToSelector:@selector(pickerViewForClickCancel)])
        {
                [weakSelf.cpDelegate pickerViewForClickCancel];
            }
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.alpha = 0;
                weakSelf.datePicker.sd_layout.bottomSpaceToView(weakSelf,-274);
                [weakSelf.datePicker updateLayout];
            } completion:^(BOOL finished)
        {
                [weakSelf removeFromSuperview];
            }];
        }];
    }
    return _cancelBtn;
}

- (UIView *)titleView{
    if (_titleView == nil)
        {
        _titleView = [UIView new];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}
@end
