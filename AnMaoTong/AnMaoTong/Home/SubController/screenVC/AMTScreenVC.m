//
//  AMTScreenVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTScreenVC.h"
#import "AMTScreenTitleView.h"
#import "AMTContentView.h"
@interface AMTScreenVC ()
@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, strong) AMTContentView *itemView;
@end

@implementation AMTScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    self.itemArr = [[NSMutableArray alloc]init];
    AMTGoodsClassModel *model = [self.titles firstObject];
    [self requestData:model.ID];
}

- (void)requestData:(NSString *)goodsID
{
    weakSelf(self);
    [[KKNetWorking getShard]request:GET url:getBrand parameters:@{@"goods_class_id":goodsID} completion:^(id json, NSInteger code) {
        weakSelf.itemArr = [AMTBrandModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        weakSelf.itemView.itemArr = weakSelf.itemArr;
    } fail:^(NSString *message, NSInteger code) {
        [SVProgressHUD showErrorHUD:message completeBlock:nil];
    }];
}

- (void)setSubView
{
    self.navBar.titieLab.text = @"筛选";
    [self.navBar.backButton setImage:imageNamed(@"icon_order_cancel") forState:UIControlStateNormal];
    weakSelf(self);
    AMTScreenTitleView *titleView = [[AMTScreenTitleView alloc]initWithFrame:CGRectMake(0, NavHFit, 90, HEIGHT_SCREEN - NavHFit - BottomYFit - 50) changeItemBlock:^(AMTGoodsClassModel *model) {
        [weakSelf requestData:model.ID];
    }];
    titleView.titles = self.titles;
    [self.view addSubview:titleView];
    
    _itemView = [[AMTContentView alloc]initWithFrame:CGRectMake(90, NavHFit, WIDTH_SCREEN - 90, titleView.height)];
    [self.view addSubview:_itemView];
    
    
    BaseButton *resetBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setTitle:@"重置" forState:(UIControlStateNormal)];
    [resetBtn setLableColor:@"FFFFFF" font:15 bold:0];
    resetBtn.backgroundColor = [UIColor cz_ToUIColorByStr:@"434343"];
    [[resetBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(id x) {
        KKLog(@"重置");
    }];
    [self.view addSubview:resetBtn];
    resetBtn.sd_layout
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .widthIs(WIDTH_SCREEN/2)
    .heightIs(50);
    
    BaseButton *determineBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [determineBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [determineBtn setLableColor:@"FFFFFF" font:15 bold:0];
    determineBtn.backgroundColor = [UIColor cz_ToUIColorByStr:@"FF3658"];
    [[determineBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(id x) {
        KKLog(@"确定");
    }];
    [self.view addSubview:determineBtn];
    determineBtn.sd_layout
    .bottomEqualToView(self.view)
    .rightEqualToView(self.view)
    .widthIs(WIDTH_SCREEN/2)
    .heightIs(50);
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
