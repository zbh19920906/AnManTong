//
//  AMTAddTitleController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTAddTitleController.h"

@interface AMTAddTitleController ()
@property (nonatomic, strong) BaseLabel *placeholderLab;
@property (nonatomic, strong) BaseLabel *countLab;
@end

@implementation AMTAddTitleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [[myNoti rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]subscribeNext:^(id x) {
        
    }];
}

- (void)setSubView
{
    self.view.backgroundColor = BHColor(@"F4F3F2");
    BaseView *bgView = [[BaseView alloc]init];
    bgView.backgroundColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
    [self.view addSubview:bgView];
    bgView.sd_layout
    .topSpaceToView(self.navBar, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(170);
    
    BaseLabel *titleLab = [[BaseLabel alloc]init];
    titleLab.text = @"标签";
    [titleLab setLableColor:@"222222" font:19 bold:0];
    
    BaseButton *addBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+ 自定义" forState:UIControlStateNormal];
    [addBtn setLableColor:@"FF3658" font:13 bold:0];
    addBtn.layer.borderColor = BHColor(@"FF3658").CGColor;
    addBtn.layer.borderWidth = 1;
    addBtn.sd_cornerRadius = @(3);
    weakSelf(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf.view becomeFirstResponder];
    }];
    
    self.placeholderLab = [[BaseLabel alloc]init];
    [self.placeholderLab setLableColor:@"B8B8B8" font:13 bold:0];
    self.placeholderLab.text = @"尚未添加";
    
    self.countLab = [[BaseLabel alloc]init];
    [self.countLab setLableColor:@"B8B8B8" font:10 bold:0];
    self.countLab.text = @"0/3";
    self.countLab.textAlignment = NSTextAlignmentRight;
    
    [bgView sd_addSubviews:@[titleLab,addBtn,self.placeholderLab, self.countLab]];
    
    titleLab.sd_layout
    .topSpaceToView(bgView, 46)
    .leftSpaceToView(bgView, 26)
    .heightIs(18)
    .widthIs(50);
    
    addBtn.sd_layout
    .topSpaceToView(bgView, 40)
    .rightSpaceToView(bgView, 28)
    .widthIs(68)
    .heightIs(30);
    
    self.placeholderLab.sd_layout
    .topSpaceToView(titleLab, 29)
    .leftSpaceToView(bgView, 27)
    .heightIs(13)
    .widthIs(55);
    
    self.countLab.sd_layout
    .bottomSpaceToView(bgView, 16)
    .rightSpaceToView(bgView, 11)
    .widthIs(20)
    .heightIs(10);
}
@end
