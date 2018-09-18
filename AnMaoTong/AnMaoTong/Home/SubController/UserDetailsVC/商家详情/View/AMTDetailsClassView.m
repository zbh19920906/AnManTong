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
    self.backgroundColor = BHColor(@"FBFCFD");
    self.amqBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.amqBtn setLableColor:@"555555" font:15 bold:0];
    [self.amqBtn setTitleColor:BHColor(@"FF3658") forState:UIControlStateSelected];
    [self.amqBtn setTitle:@"安贸圈" forState:UIControlStateNormal];
    
    self.productBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.productBtn setLableColor:@"555555" font:15 bold:0];
    [self.productBtn setTitleColor:BHColor(@"FF3658") forState:UIControlStateSelected];
    [self.productBtn setTitle:@"产品" forState:UIControlStateNormal];
    
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
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
