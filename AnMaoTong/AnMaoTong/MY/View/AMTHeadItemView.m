//
//  AMTHeadItemView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHeadItemView.h"
@interface AMTHeadItemView ()

@end

@implementation AMTHeadItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    
    self.titleLab = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"222222" font:15 bold:0];
    
    self.contentLab = [[BaseLabel alloc]init];
    [self.contentLab setLableColor:@"959595" font:12 bold:0];
    
    [self sd_addSubviews:@[self.titleLab,self.contentLab]];
    
    self.titleLab.sd_layout
    .topSpaceToView(self, 7)
    .centerXEqualToView(self)
    .heightIs(12);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:40];
    
    self.contentLab.sd_layout
    .topSpaceToView(self.titleLab, 9)
    .centerXEqualToView(self)
    .heightIs(12);
    [self.contentLab setSingleLineAutoResizeWithMaxWidth:40];
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        
    }];
}
@end
