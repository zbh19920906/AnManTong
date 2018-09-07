//
//  AMTContactViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTContactViewController.h"
#import "AMTGoodsClassViewController.h"
@interface AMTContactViewController ()

@end

@implementation AMTContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView
{
    weakSelf(self);
    self.titleLab.text = @"您的联系方式？";
    
    BaseTextField *textField = [[BaseTextField alloc]init];
    textField.placeholder = KKString(@"请输入微信号");
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
    
    BaseTextField *qqTextField = [[BaseTextField alloc]init];
    qqTextField.placeholder = KKString(@"请输入QQ号");
    qqTextField.textColor = BHColor(@"000000");
    qqTextField.font = [UIFont systemFontOfSize:15];
    qqTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[qqTextField rac_textSignal] subscribeNext:^(id x) {
        if ([weakSelf.model.type isEqualToString:@"1"]) {
            weakSelf.model.nickname = x;
        }else{
            weakSelf.model.name = x;
        }
    }];
    
    RAC(self.nextBtn,backgroundColor) = [[[textField rac_textSignal] merge:[qqTextField rac_textSignal]] map:^id(id value) {
        if (textField.text.length > 0 && qqTextField.text.length >0) {
           weakSelf.nextBtn.enabled = YES;
            return BHColor(@"FF3658");
        }else{
            weakSelf.nextBtn.enabled = NO;
            return [UIColor cz_colorWithRed:243 green:178 blue:188];
        }
    }];
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        AMTGoodsClassViewController *vc = [[AMTGoodsClassViewController alloc]init];
        vc.model = weakSelf.model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.view sd_addSubviews:@[textField,qqTextField]];
    
    textField.sd_layout
    .topSpaceToView(self.titleLab, 70)
    .leftSpaceToView(self.view, 27)
    .rightSpaceToView(self.view, 27)
    .heightIs(20);
    [textField addBottomLineWithOffset:-10 left:-5 right:-5 color:BHColor(@"E5E5E5") height:.5];
    
    qqTextField.sd_layout
    .topSpaceToView(textField, 26)
    .leftSpaceToView(self.view, 27)
    .rightSpaceToView(self.view, 27)
    .heightIs(20);
    [qqTextField addBottomLineWithOffset:-10 left:-5 right:-5 color:BHColor(@"E5E5E5") height:.5];
    
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
