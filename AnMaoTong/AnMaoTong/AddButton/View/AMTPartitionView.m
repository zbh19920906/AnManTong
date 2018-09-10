//
//  AMTPartitionView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/10.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPartitionView.h"

@implementation AMTPartitionView
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
    [self.titleLab setLableColor:@"959595" font:13 bold:0];
    
    
    self.contentLab = [[BaseLabel alloc]init];
    [self.contentLab setLableColor:@"CCCCCC" font:13 bold:0];
    
    [self sd_addSubviews:@[self.titleLab,self.contentLab]];
    
    self.titleLab.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 11)
    .heightIs(13);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.contentLab.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 63)
    .heightIs(13);
    [self.contentLab setSingleLineAutoResizeWithMaxWidth:250];
    
     self.tap = [UITapGestureRecognizer new];
    [self addGestureRecognizer:self.tap];
}
@end
