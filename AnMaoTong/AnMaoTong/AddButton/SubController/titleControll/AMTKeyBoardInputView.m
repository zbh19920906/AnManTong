//
//  AMTKeyBoardInputView.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTKeyBoardInputView.h"
@interface AMTKeyBoardInputView ()
@property (nonatomic, strong) BaseView *inputView;

@property (nonatomic, strong) BaseTextField *inputTF;
@property (nonatomic, strong) BaseLabel *countLab;

@property (nonatomic, strong) BaseButton *determineBtn;
@end
@implementation AMTKeyBoardInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    BaseView *bgView = [[BaseView alloc]init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    
    bgView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    self.inputView = [[BaseView alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 45)];
    self.inputView.backgroundColor = BHColor(@"F7F7F7");
    
    
    self.countLab = [[BaseLabel alloc]initWithFrame:CGRectMake(0, 0, 25, 12)];
    [self.countLab setLableColor:@"C8C8C8" font:12 bold:0];
    self.countLab.text = @"0/4";
    
    self.inputTF = [[BaseTextField alloc]init];
    self.inputTF.placeholder = @"添加自定义标签";
    self.inputTF.sd_cornerRadius = @(3);
    self.inputTF.rightView = self.countLab;
    self.inputTF.rightViewMode = UITextFieldViewModeAlways;

    self.determineBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.determineBtn setLableColor:@"0085FF" font:12 bold:0];
    [self.determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [self addSubview:self.inputView];
    [self.inputView sd_addSubviews:@[self.inputTF,self.determineBtn]];
    
    self.inputTF.sd_layout
    .centerYEqualToView(self.inputView)
    .leftSpaceToView(self.inputView, 10)
    .heightIs(30)
    .widthIs(WIDTH_SCREEN - 75);
    
    self.determineBtn.sd_layout
    .centerYEqualToView(self.inputView)
    .rightSpaceToView(self.inputView, 10)
    .widthIs(36)
    .heightIs(30);
    
}

- (void)show
{
    
}

@end
