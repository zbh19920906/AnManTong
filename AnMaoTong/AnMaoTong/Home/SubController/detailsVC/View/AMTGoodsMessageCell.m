//
//  AMTGoodsMessageCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTGoodsMessageCell.h"
#import "AMTGoodsImageView.h"
#import "AMTGoodsTitleView.h"
@interface AMTGoodsMessageCell ()
@property (nonatomic, strong) BaseImageView *headImageView;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *timeLab;
@property (nonatomic, strong) BaseLabel *contentLab;
@property (nonatomic, strong) AMTGoodsImageView *goodsImageView;
@property (nonatomic, strong) BaseImageView *addressImageView;
@property (nonatomic, strong) BaseLabel *addressLab;
@property (nonatomic, strong) BaseImageView *iconImage;
@property (nonatomic, strong) AMTGoodsTitleView *titleView;
@end
@implementation AMTGoodsMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.headImageView = [[BaseImageView alloc]init];
    self.headImageView.sd_cornerRadius = @(20);
    self.headImageView.backgroundColor = [UIColor redColor];
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FF3658" font:14 bold:0];
    
    self.timeLab = [[BaseLabel alloc]init];
    [self.timeLab setLableColor:@"CCCCCC" font:11 bold:0];
    
    self.contentLab = [[BaseLabel alloc]init];
    [self.contentLab setLableColor:@"555555" font:14 bold:0];
    
    self.goodsImageView = [[AMTGoodsImageView alloc]init];
    
    self.addressImageView = [[BaseImageView alloc]initWithImage:imageNamed(@"location")];
    
    self.addressLab = [[BaseLabel alloc]init];
    [self.addressLab setLableColor:@"CCCCCC" font:11 bold:0];
    
    self.iconImage = [[BaseImageView alloc]init];
    
    self.titleView = [[AMTGoodsTitleView alloc]init];
    
    [self.contentView sd_addSubviews:@[self.headImageView,self.nameLab,self.timeLab,self.contentLab,self.goodsImageView,self.addressImageView,self.addressLab,self.iconImage,self.titleView]];
    
    self.headImageView.sd_layout
    .topSpaceToView(self.contentView, 18)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .topSpaceToView(self.contentView, 22)
    .leftSpaceToView(self.headImageView, 10)
    .heightIs(14);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLab.sd_layout
    .topSpaceToView(self.nameLab, 10)
    .leftEqualToView(self.nameLab)
    .heightIs(11);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLab.sd_layout
    .topSpaceToView(self.timeLab, 22)
    .leftSpaceToView(self.contentView, 11)
    .rightSpaceToView(self.contentView, 11)
    .autoHeightRatio(0);
    
    self.iconImage.sd_layout
    .topEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(23)
    .heightIs(29);
    
    self.goodsImageView.sd_layout
    .topSpaceToView(self.contentLab, 14)
    .leftEqualToView(self.contentView)
    .widthIs(WIDTH_SCREEN)
    .heightIs((WIDTH_SCREEN - 37)/3);
    
    self.titleView.sd_layout
    .topSpaceToView(self.goodsImageView, 13)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(15);
    
    
    self.addressImageView.sd_layout
    .topSpaceToView(self.titleView, 15)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(9)
    .heightIs(11);
    
    self.addressLab.sd_layout
    .leftSpaceToView(self.addressImageView, 5)
    .centerYEqualToView(self.addressImageView)
    .heightIs(11);
    [self.addressLab setSingleLineAutoResizeWithMaxWidth:250];
    
}

- (void)setModel:(AMTDetailsModel *)model
{
    self.nameLab.text = model.type == 1 ? model.nickname : model.name;
    [self.headImageView sd_setImageWithURL:UrlString(model.head_img)];
    self.timeLab.text = model.auth_time;
    self.contentLab.text = model.title;
    self.goodsImageView.images = model.images;
    self.addressLab.text = model.position;
    self.titleView.titles = model.titles;
    self.iconImage.image = imageNamed(model.type == 1 ? @"gong" : @"qiu");
    [self setupAutoHeightWithBottomView:self.addressLab bottomMargin:10];
}
@end
