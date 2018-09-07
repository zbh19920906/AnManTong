//
//  AMTMyHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyHeadView.h"
#import "AMTHeadInfoView.h"
@interface AMTMyHeadView ()
@property (nonatomic, strong) BaseImageView *bgImage;
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *contentLab;
@property (nonatomic, strong) AMTHeadInfoView *headInfoView;
@end
@implementation AMTMyHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.bgImage = [[BaseImageView alloc]init];
    
    self.headImage = [[BaseImageView alloc]init];
    self.headImage.image = imageNamed(@"headImage");
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FFFFFF" font:20 bold:0];
    self.nameLab.text = @"未登录";
    
    self.contentLab = [[BaseLabel alloc]init];
    [self.contentLab setLableColor:@"FEFEFF" font:11 bold:0];
    self.contentLab.text = @"点击立即登录";
    
    self.headInfoView = [[AMTHeadInfoView alloc]init];
    
    self.changeBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.sd_cornerRadius = @(3);
    [self.changeBtn setLableColor:@"FFFFFF" font:13 bold:0];
    [self.changeBtn setBackgroundColor:BHColor(@"000000")];
    [self.changeBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [self sd_addSubviews:@[self.bgImage,self.headImage,self.nameLab,self.contentLab,self.headInfoView,self.changeBtn]];
    
    self.bgImage.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 23, 0));
    
    self.headImage.sd_layout
    .topSpaceToView(self, 72)
    .leftSpaceToView(self, 16)
    .widthIs(80)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .topSpaceToView(self.headImage, 16)
    .leftEqualToView(self.headImage)
    .heightIs(19);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:250];
    
    self.contentLab.sd_layout
    .topSpaceToView(self.nameLab, 17)
    .leftEqualToView(self.nameLab)
    .heightIs(11);
    [self.contentLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.headInfoView.sd_layout
    .bottomEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(75);
    
    self.changeBtn.sd_layout
    .centerYEqualToView(self.headImage)
    .rightSpaceToView(self, 16)
    .widthIs(40)
    .heightEqualToWidth();
}

- (void)setModel:(AMTMyModel *)model
{
    [self.headInfoView layoutIfNeeded];
}
@end
