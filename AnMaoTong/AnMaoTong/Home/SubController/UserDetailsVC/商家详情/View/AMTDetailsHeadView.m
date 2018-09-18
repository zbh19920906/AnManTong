//
//  AMTDetailsHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsHeadView.h"
@interface AMTDetailsHeadView ()
@property (nonatomic, strong) BaseImageView *bgImageView;
@property (nonatomic, strong) BaseImageView *headIamgeView;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *announcementLab;
@property (nonatomic, strong) BaseButton *focusBtn;
@end
@implementation AMTDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.bgImageView = [[BaseImageView alloc]init];
    self.bgImageView.backgroundColor = [UIColor greenColor];
    
    self.headIamgeView = [[BaseImageView alloc]init];
    self.headIamgeView.sd_cornerRadius = @(40);
    self.headIamgeView.backgroundColor = [UIColor redColor];
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FFFFFF" font:20 bold:1];
    self.nameLab.text = @"阿迪达斯三叶草";
    
    self.announcementLab = [[BaseLabel alloc]init];
    [self.announcementLab setLableColor:@"FFFFFF" font:13 bold:0];
    self.announcementLab.text = @"公告：轻奢品牌天猫品质保证+厂家直供购物无忧+已质检精选好货 出门3分钟搞定造型 超随性百搭美到醉人";
    
    
    self.focusBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn.sd_cornerRadius = @(3);
    [self.focusBtn setLableColor:@"FFFFFF" font:13 bold:0];
    [self.focusBtn setBackgroundColor:BHColor(@"000000")];
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    
    [self sd_addSubviews:@[self.bgImageView,self.headIamgeView,self.nameLab,self.focusBtn]];
    
    self.bgImageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    self.headIamgeView.sd_layout
    .topSpaceToView(self, 85)
    .leftSpaceToView(self, 16)
    .widthIs(80)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .topSpaceToView(self.headIamgeView, 16)
    .leftSpaceToView(self, 17)
    .heightIs(20);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.announcementLab.sd_layout
    .topSpaceToView(self.nameLab, 20)
    .leftSpaceToView(self, 16)
    .rightSpaceToView(self, 19)
    .autoHeightRatio(0)
    .maxHeightIs(35);
    
    self.focusBtn.sd_layout
    .centerYEqualToView(self.headIamgeView)
    .rightSpaceToView(self, 16)
    .widthIs(40)
    .heightEqualToWidth();
}


@end
