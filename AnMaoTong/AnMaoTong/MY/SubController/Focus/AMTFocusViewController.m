//
//  AMTFocusViewController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFocusViewController.h"
#import "AMTFocusShopController.h"
#import "AMTFocusUserController.h"
@interface AMTFocusViewController ()
@property(strong, nonatomic) KKClassiflcationLayout *layout;
@property(strong, nonatomic) KKClassificationView *managerView;
@end

@implementation AMTFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.titieLab.text = @"我的关注";
    [self.view addSubview:self.managerView];
}

#pragma mark - 懒加载
-(KKClassificationView *)managerView
{
    if (!_managerView) {
        weakSelf(self);
        _managerView = [[KKClassificationView alloc]initWithFrame:CGRectMake(0, NavHFit, self.view.bounds.size.width, HEIGHT_SCREEN - NavHFit) viewController:self layout:self.layout clickBlock:^(NSInteger index) {
            
        }];
    }
    return _managerView;
}

-(KKClassiflcationLayout *)layout
{
    if (!_layout) {
        _layout = [[KKClassiflcationLayout alloc] init];
        _layout.isAverage = YES;
        _layout.titleViewBgColor = [UIColor cz_ToUIColorByStr:@"FFFFFF"];
        //控制滑块高度
        _layout.sliderHeight = 40;
        _layout.titleSelectColor = [UIColor cz_ToUIColorByStr:@"FF3658"];
        _layout.titleColor = [UIColor cz_ToUIColorByStr:@"959595"];
        _layout.titleFont = [UIFont systemFontOfSize:13];
        _layout.titles = @[@"商家",@"用户"];
        _layout.viewControllers = @[[AMTFocusShopController new],[AMTFocusUserController new]];
        _layout.bottomLineHeight = 1;
        _layout.bottomLineWidth = 25;
        _layout.bottomLineColor = BHColor(@"FF3658");
        _layout.linkHeight = 1;
        _layout.LinkColor = [UIColor cz_ToUIColorByStr:@"eeeeee"];
    }
    return _layout;
}

@end
