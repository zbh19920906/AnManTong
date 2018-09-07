
//
//  AMTMyCollectionCell.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyCollectionCell.h"
@interface AMTMyCollectionCell ()
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *titleLab;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *timeLab;
@property (nonatomic, strong) BaseButton *foucusBtn;
@end
@implementation AMTMyCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            [self setSubView:!reuseIdentifier];
    }
    return self;
}

- (void)setSubView:(BOOL)isView;
{
    self.headImage = [[BaseImageView alloc]init];
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FF3658" font:13 bold:0];
    self.nameLab.text = @"鸿星尔克";
    
    self.titleLab = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"555555" font:13 bold:0];
    self.titleLab.text = @"skechers斯凯奇撞色运动休闲鞋动休闲鞋 低价批发，工厂直销";
    
    self.timeLab = [[BaseLabel alloc]init];
    [self.timeLab setLableColor:@"CCCCCC" font:11 bold:0];
    self.timeLab.text = @"2018-08-27";
    
    self.foucusBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.foucusBtn setLableColor:@"FF3658" font:12 bold:0];
    [self.foucusBtn setTitleColor:BHColor(@"CCCCCC") forState:UIControlStateSelected];
    self.foucusBtn.layer.borderColor = [UIColor cz_ToUIColorByStr:@"FF3658"].CGColor;
    self.foucusBtn.layer.borderWidth = 1;
    [self.foucusBtn setTitle:@"收藏" forState:UIControlStateNormal];
    self.foucusBtn.hidden = isView;
    [self.contentView sd_addSubviews:@[self.headImage,self.nameLab,self.timeLab,self.titleLab,self.foucusBtn]];
    
    self.headImage.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(isView ? 81 : 100)
    .heightEqualToWidth();
    
    self.titleLab.sd_layout
    .topSpaceToView(self.contentView, isView ? 14 : 20)
    .leftSpaceToView(self.headImage,15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    self.nameLab.sd_layout
    .topSpaceToView(self.titleLab, isView ? 14 : 24)
    .leftEqualToView(self.titleLab)
    .heightIs(13);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLab.sd_layout
    .topSpaceToView(self.nameLab, isView ? 11 : 15)
    .leftEqualToView(self.nameLab)
    .heightIs(11);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.foucusBtn.sd_layout
    .bottomSpaceToView(self.contentView, 23)
    .rightSpaceToView(self.contentView, 11)
    .heightIs(25)
    .widthIs(57);
}
@end
