//
//  AMTBaseInfoViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTBaseInfoViewController.h"

@interface AMTBaseInfoViewController ()

@end

@implementation AMTBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"222222" font:27 bold:1];
    [self.view addSubview:self.titleLab];
    self.titleLab.sd_layout
    .topSpaceToView(self.view, 106)
    .leftSpaceToView(self.view, 21)
    .heightIs(26);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:300];
    
   self.nextBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setBackgroundColor:BHColor(@"FF3658")];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setLableColor:@"FFFFFF" font:16 bold:0];
    [self.nextBtn setSd_cornerRadius:@(23)];
    [self.view addSubview:self.nextBtn];
    
    self.nextBtn.sd_layout
    .topSpaceToView(self.titleLab, 227)
    .centerXEqualToView(self.view)
    .widthIs(196)
    .heightIs(45);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
