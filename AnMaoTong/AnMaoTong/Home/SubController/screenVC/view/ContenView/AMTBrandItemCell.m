//
//  AMTBrandItemCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTBrandItemCell.h"
@interface AMTBrandItemCell ()
@property (nonatomic, strong) BaseButton *itmeBtn;
@end
@implementation AMTBrandItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    _itmeBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    _itmeBtn.sd_cornerRadius = @(4);
    [_itmeBtn setBackgroundColor:[UIColor whiteColor]];
    _itmeBtn.layer.borderWidth = 1;
    _itmeBtn.layer.borderColor = [UIColor cz_ToUIColorByStr:@"DCDCDC"].CGColor;
    [_itmeBtn setLableColor:@"BBBBBB" font:12 bold:0];
    [self.contentView addSubview:_itmeBtn];
    
    _itmeBtn.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setModel:(AMTBrandModel *)model
{
    [_itmeBtn setTitle:model.name forState:UIControlStateNormal];
}
@end
