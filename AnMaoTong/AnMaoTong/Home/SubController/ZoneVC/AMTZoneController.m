//
//  AMTZoneController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTZoneController.h"
#import "AMTZoneMainController.h"
#import "AMTScreenVC.h"
#import "AMTDetailsVC.h"
#import "KKSearchGoodsViewController.h"
@interface AMTZoneController ()

@property (nonatomic, strong) NSMutableArray *titleArr;
@property(strong, nonatomic) KKClassiflcationLayout *layout;
@property(strong, nonatomic) KKClassificationView *managerView;
@property(copy, nonatomic) NSMutableArray *viewControllers;
@end

@implementation AMTZoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = @"安贸通";
    [self.navBar.rightButton setImage:imageNamed(@"search") forState:UIControlStateNormal];
    weakSelf(self);
    [[KKNetWorking getShard]request:GET url:getGoodsClass parameters:nil completion:^(id json, NSInteger code) {
        weakSelf.titleArr = [AMTGoodsClassModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        [weakSelf.view addSubview:weakSelf.managerView];
    } fail:^(NSString *message, NSInteger code) {
        [SVProgressHUD showErrorHUD:message completeBlock:nil];
    }];
    
}

- (void)clickRightButtonAction:(id)sender
{
    KKSearchGoodsViewController *search  =[[KKSearchGoodsViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - 懒加载
-(KKClassificationView *)managerView
{
    if (!_managerView) {
        weakSelf(self);
        _managerView = [[KKClassificationView alloc]initWithFrame:CGRectMake(0, NavHFit, self.view.bounds.size.width, HEIGHT_SCREEN - NavHFit) viewController:self layout:self.layout clickBlock:^(NSInteger index) {
            //            AMTScreenVC *vc =[[AMTScreenVC alloc]init];
            //            vc.titles = weakSelf.titleArr;
            AMTDetailsVC *vc = [[AMTDetailsVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _managerView;
}

-(KKClassiflcationLayout *)layout
{
    if (!_layout) {
        _layout = [[KKClassiflcationLayout alloc] init];
        _layout.titleViewBgColor = [UIColor cz_ToUIColorByStr:@"F5F5F5"];
        _layout.lrMargin = 10;
        //控制滑块高度
        _layout.sliderHeight = 38;
        _layout.titleMargin = 20;
        _layout.titleSelectColor = [UIColor cz_ToUIColorByStr:@"222222"];
        _layout.titleColor = [UIColor cz_ToUIColorByStr:@"959595"];
        _layout.titleFont = [UIFont systemFontOfSize:13];
        _layout.titles = self.titleArr;
        _layout.viewControllers = self.viewControllers;
        _layout.LinkColor = [UIColor cz_ToUIColorByStr:@"eeeeee"];
        _layout.isHidenBottomLine = YES;
    }
    return _layout;
}

- (NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc]init];
    }
    return _titleArr;
}

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc]init];
        for (NSInteger i = 0 ; i < self.titleArr.count; i ++) {
            AMTZoneMainController *vc = [[AMTZoneMainController alloc]init];
            AMTGoodsClassModel *model = self.titleArr[i];
            vc.goods_class_id = model.ID;
            [_viewControllers addObject:vc];
        }
    }
    return _viewControllers;
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