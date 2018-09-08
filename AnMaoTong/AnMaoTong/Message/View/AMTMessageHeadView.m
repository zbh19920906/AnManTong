
//
//  AMTMessageHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/8.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMessageHeadView.h"

@implementation AMTMessageHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.backgroundColor = [UIColor whiteColor];
    [self addShadowWithOffset:CGSizeMake(3, 3) color:BHColor(@"000000") radius:3 opacity:.1];
    
    BaseLabel *titleLab = [[BaseLabel alloc]init];
    titleLab.text = @"消息";
    [titleLab setLableColor:@"222222" font:20 bold:1];
    
    self.unreadMessageLab = [[BaseLabel alloc]init];
    [self.unreadMessageLab setLableColor:@"959595" font:12 bold:0];
    self.unreadMessageLab.text = @"3条消息未读";
    
    [self sd_addSubviews:@[titleLab,self.unreadMessageLab]];
    
    titleLab.sd_layout
    .topSpaceToView(self, 52)
    .leftSpaceToView(self, 16)
    .heightIs(19);
    [titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.unreadMessageLab.sd_layout
    .topSpaceToView(titleLab, 13)
    .leftEqualToView(titleLab)
    .heightIs(12);
    [self.unreadMessageLab setSingleLineAutoResizeWithMaxWidth:250];
    
            
}
@end
