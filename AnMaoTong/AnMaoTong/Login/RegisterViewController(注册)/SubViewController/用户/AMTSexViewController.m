//
//  AMTSexViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTSexViewController.h"

@interface AMTSexViewController ()

@end

@implementation AMTSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView
{
    weakSelf(self);
    self.titleLab.text = @"您的性别？";
    
  __block  BaseButton *oldBtn;
    
    BaseButton *manBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    [manBtn setImage:imageNamed(@"sex") forState:UIControlStateNormal];
    [manBtn setImage:imageNamed(@"man") forState:UIControlStateSelected];
    [manBtn setLableColor:@"555555" font:18 bold:0];
    [manBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, -4)];
    [[manBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {

        oldBtn.selected = NO;
        manBtn.selected = YES;
        oldBtn = manBtn;
        weakSelf.model.sex = @"1";
    }];
    
    
    BaseButton *womanBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [womanBtn setTitle:@"女" forState:UIControlStateNormal];
    [womanBtn setImage:imageNamed(@"sex") forState:UIControlStateNormal];
    [womanBtn setImage:imageNamed(@"woman") forState:UIControlStateSelected];
    [womanBtn setLableColor:@"555555" font:18 bold:0];
    [womanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, -4)];
    [[womanBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        oldBtn.selected = NO;
        womanBtn.selected = YES;
        oldBtn = womanBtn;
        weakSelf.model.sex = @"2";
    }];
    
    [self.nextBtn setBackgroundColor:[UIColor cz_colorWithRed:243 green:178 blue:188]];
    RAC(self.nextBtn,backgroundColor) = [[[manBtn rac_signalForControlEvents:UIControlEventTouchUpInside] merge:[womanBtn rac_signalForControlEvents:UIControlEventTouchUpInside]] map:^id(id value) {
        if (manBtn.selected || womanBtn.selected) {
           weakSelf.nextBtn.enabled = YES;
            return BHColor(@"FF3658");
        }else{
            weakSelf.nextBtn.enabled = NO;
            return [UIColor cz_colorWithRed:243 green:178 blue:188];
        }
    }];
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    [self.view sd_addSubviews:@[manBtn,womanBtn]];
    
    manBtn.sd_layout
    .topSpaceToView(self.titleLab, 90)
    .leftSpaceToView(self.view, 26)
    .heightIs(25)
    .widthIs(50);
    
    womanBtn.sd_layout
    .topSpaceToView(self.titleLab, 90)
    .rightSpaceToView(self.view, 26)
    .heightIs(25)
    .widthIs(50);
}

@end
