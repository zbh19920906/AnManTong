//
//  AMTUserNameViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTUserNameViewController.h"
#import "AMTContactViewController.h"
#import "AMTSexViewController.h"
@interface AMTUserNameViewController ()

@end

@implementation AMTUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView
{
    weakSelf(self);
    self.titleLab.text = [self.model.type isEqualToString:@"1"] ? @"您的昵称？" : @"您的商家名称？";
    
    BaseTextField *textField = [[BaseTextField alloc]init];
    textField.placeholder = KKString([self.model.type isEqualToString:@"1"] ? @"请输入您的昵称" : @"请输入商家名称");
    textField.textColor = BHColor(@"000000");
    textField.font = [UIFont systemFontOfSize:15];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[textField rac_textSignal] subscribeNext:^(id x) {
        if ([weakSelf.model.type isEqualToString:@"1"]) {
            weakSelf.model.nickname = x;
        }else{
            weakSelf.model.name = x;
        }
    }];
    
    RAC(self.nextBtn,backgroundColor) = [[textField rac_textSignal] map:^id(id value) {
        if (textField.text.length > 0) {
           weakSelf.nextBtn.enabled = YES;
            return BHColor(@"FF3658");
        }else{
            weakSelf.nextBtn.enabled = NO;
            return [UIColor cz_colorWithRed:243 green:178 blue:188];
        }
    }];
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([weakSelf.model.type isEqualToString:@"1"]) {
            AMTSexViewController *vc = [[AMTSexViewController alloc]init];
            vc.model = weakSelf.model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            AMTContactViewController *vc = [[AMTContactViewController alloc]init];
            vc.model = weakSelf.model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    [self.view sd_addSubviews:@[textField]];
    
    textField.sd_layout
    .topSpaceToView(self.titleLab, 70)
    .leftSpaceToView(self.view, 27)
    .rightSpaceToView(self.view, 27)
    .heightIs(20);
    [textField addBottomLineWithOffset:-10 left:-5 right:-5 color:BHColor(@"E5E5E5") height:.5];
    
}
@end
