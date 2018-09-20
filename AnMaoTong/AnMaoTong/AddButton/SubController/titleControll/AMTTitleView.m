//
//  AMTTitleView.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTTitleView.h"

@implementation AMTTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews
{
    self.backgroundColor = BHColor(@"FF3658");
    
    self.titleLab = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"FFFFFF" font:13 bold:0];
    
    
   self.button = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:imageNamed(@"关闭") forState:UIControlStateNormal];
    
    [self sd_addSubviews:@[self.titleLab,self.button]];
    
    self.titleLab.sd_layout
    .leftSpaceToView(self, 14)
    .centerYEqualToView(self)
    .heightIs(13);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.button.sd_layout
    .rightSpaceToView(self, 7)
    .centerYEqualToView(self)
    .heightIs(15)
    .widthIs(15);
    
}
@end
