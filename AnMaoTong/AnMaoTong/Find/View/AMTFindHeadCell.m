//
//  AMTFindHeadCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFindHeadCell.h"
@interface AMTFindHeadCell ()
@property (nonatomic, strong) BaseImageView *iconImage;
@property (nonatomic, strong) BaseLabel *titleLab;
@end
@implementation AMTFindHeadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.iconImage = [[BaseImageView alloc]init];
    self.iconImage.backgroundColor = [UIColor redColor];
    self.iconImage.sd_cornerRadius = @(21.5);
    
    self.titleLab  = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"666666" font:11 bold:0];
    self.titleLab.text = @"新威";
    
    [self.contentView sd_addSubviews:@[self.iconImage,self.titleLab]];
    self.iconImage.sd_layout
    .centerXEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthIs(43)
    .heightEqualToWidth();
    
    self.titleLab.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.iconImage, 6)
    .heightIs(11);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:200];
    
}
@end
