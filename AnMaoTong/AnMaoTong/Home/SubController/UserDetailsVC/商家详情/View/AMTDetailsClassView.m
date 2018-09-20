//
//  AMTDetailsClassView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsClassView.h"
@interface AMTDetailsClassView ()
@property (nonatomic, strong) BaseButton *amqBtn;
@property (nonatomic, strong) BaseButton *productBtn;
@property (nonatomic, strong) BaseButton *oldButton;
@property (nonatomic, strong) BaseView *linkView;
@end
@implementation AMTDetailsClassView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.backgroundColor = [UIColor blackColor];
    
    BaseView *bgView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    bgView.backgroundColor = BHColor(@"FBFCFD");
    [self addSubview:bgView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.frame;
    //赋值
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    
    self.amqBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.amqBtn setLableColor:@"555555" font:15 bold:0];
    [self.amqBtn setTitleColor:BHColor(@"FF3658") forState:UIControlStateSelected];
    [self.amqBtn setTitle:@"安贸圈" forState:UIControlStateNormal];
    self.amqBtn.tag = 1;
    [self.amqBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.oldButton = self.amqBtn;
    
    self.productBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.productBtn setLableColor:@"555555" font:15 bold:0];
    [self.productBtn setTitleColor:BHColor(@"FF3658") forState:UIControlStateSelected];
    [self.productBtn setTitle:@"产品" forState:UIControlStateNormal];
    self.productBtn.tag = 2;
    [self.productBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.linkView = [[BaseView alloc]init];
    self.linkView.backgroundColor = BHColor(@"FF3658");
    
    [self sd_addSubviews:@[self.amqBtn,self.productBtn,self.linkView]];
    
    self.amqBtn.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .widthIs(self.width/2)
    .heightIs(self.height);
    
    self.productBtn.sd_layout
    .topEqualToView(self)
    .rightEqualToView(self)
    .widthIs(self.width/2)
    .heightIs(self.height);
    
    self.linkView.sd_layout
    .centerXEqualToView(self.amqBtn)
    .bottomEqualToView(self)
    .widthIs(30)
    .heightIs(3);
    
    [self buttonClick:self.amqBtn];
    
    [self layoutIfNeeded];
}

- (void)buttonClick:(BaseButton *)button
{
    self.oldButton.selected = NO;
    button.selected = YES;
    if (self.oldButton.tag != button.tag) {
        [self requsetData:button.tag];
    }
    self.oldButton = button;
    [UIView animateWithDuration:0.25 animations:^{
       self.linkView.sd_layout
        .centerXEqualToView(self.oldButton);
        [self setNeedsLayout];
        [self.linkView setNeedsLayout];
    }];
}

- (void)requsetData:(NSInteger)tag
{
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

}

@end
