//
//  AMTFocusShopCell.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFocusShopCell.h"
@interface AMTFocusShopCell ()
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *weChatLab;
@property (nonatomic, strong) BaseButton *foucusBtn;
@end
@implementation AMTFocusShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.headImage = [[BaseImageView alloc]init];
    self.headImage.sd_cornerRadius = @(20);
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FF3658" font:13 bold:0];
    self.nameLab.text = @"鸿星尔克";
    
    self.weChatLab = [[BaseLabel alloc]init];
    [self.weChatLab setLableColor:@"CCCCCC" font:11 bold:0];
    self.weChatLab.text = @"微信号：MKQD99999  QQ：35625645";
    
    self.foucusBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.foucusBtn setLableColor:@"FF3658" font:12 bold:0];
    [self.foucusBtn setTitleColor:BHColor(@"CCCCCC") forState:UIControlStateSelected];
    self.foucusBtn.layer.borderColor = [UIColor cz_ToUIColorByStr:@"FF3658"].CGColor;
    self.foucusBtn.layer.borderWidth = 1;
    [self.foucusBtn setTitle:@"关注" forState:UIControlStateNormal];
    
    [self.contentView sd_addSubviews:@[self.headImage,self.nameLab,self.weChatLab,self.foucusBtn]];
    
    self.headImage.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    
    self.nameLab.sd_layout
    .topSpaceToView(self.contentView, 23)
    .leftSpaceToView(self.headImage, 10)
    .heightIs(13);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.weChatLab.sd_layout
    .topSpaceToView(self.nameLab, 9)
    .leftEqualToView(self.nameLab)
    .heightIs(11);
    [self.weChatLab setSingleLineAutoResizeWithMaxWidth:300];
    
    self.foucusBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 11)
    .heightIs(25)
    .widthIs(57);
}

@end
