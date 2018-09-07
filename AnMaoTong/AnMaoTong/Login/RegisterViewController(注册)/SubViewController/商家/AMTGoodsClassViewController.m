//
//  AMTGoodsClassViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTGoodsClassViewController.h"

@interface AMTGoodsClassViewController ()<PersonalRadioViewDelegate>
@property (nonatomic, strong) BaseButton *classBtn;
@end

@implementation AMTGoodsClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
}

- (void)setSubView
{
    weakSelf(self);
    self.titleLab.text = @"商品分类？";
    
    _classBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [_classBtn setLableColor:@"555555" font:20 bold:0];
    [_classBtn setTitle:@"鞋类" forState:UIControlStateNormal];
    _classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[_classBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PersonalRadioView *radioView = [PersonalRadioView radioViewWithTitle:@"选择分类"];
        radioView.cpDelegate = weakSelf;
        radioView.dataSource = @[@"自主品牌",@"鞋类", @"包包", @"手表"];
        [weakSelf.navigationController.view addSubview:radioView];
    }];
    [self.view addSubview:_classBtn];
    
    _classBtn.sd_layout
    .topSpaceToView(self.titleLab, 70)
    .leftSpaceToView(self.view, 27)
    .rightSpaceToView(self.view, 27)
    .heightIs(20);
    [_classBtn addBottomLineWithOffset:-10 left:-5 right:-5 color:BHColor(@"E5E5E5") height:.5];
    
}

- (void)radioViewClick:(NSString *)valueStr
{
    [_classBtn setTitle:valueStr forState:UIControlStateNormal];
}
@end
