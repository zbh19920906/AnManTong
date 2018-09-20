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
#import "AMTDynamicCountView.h"
@interface AMTGoodsMessageCell ()
@property (nonatomic, strong) BaseView *bgView;
@property (nonatomic, strong) BaseImageView *headImageView;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *timeLab;
@property (nonatomic, strong) BaseLabel *contentLab;
@property (nonatomic, strong) AMTGoodsImageView *goodsImageView;
@property (nonatomic, strong) BaseImageView *addressImageView;
@property (nonatomic, strong) BaseLabel *addressLab;
@property (nonatomic, strong) BaseImageView *iconImage;
@property (nonatomic, strong) AMTGoodsTitleView *titleView;
@property (nonatomic, strong) AMTDynamicCountView *countView;
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
    self.bgView = [[BaseView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.bgView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 10, 0));
    
    self.headImageView = [[BaseImageView alloc]init];
    self.headImageView.sd_cornerRadius = @(20);
    self.headImageView.backgroundColor = [UIColor redColor];
    
    _headTap = [UITapGestureRecognizer new];
    
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:_headTap];
    
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
    
    self.countView = [[AMTDynamicCountView alloc]init];
    
    [self.contentView sd_addSubviews:@[self.headImageView,self.nameLab,self.timeLab,self.contentLab,self.goodsImageView,self.addressImageView,self.addressLab,self.iconImage,self.titleView,self.countView]];
    
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
    .topSpaceToView(self.headImageView, 18)
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
    
   
}

- (void)setModel:(AMTDetailsModel *)model
{
    _model = model;
    self.nameLab.text = model.type == 1 ? model.nickname : model.name;
    [self.headImageView sd_setImageWithURL:UrlString(model.head_img)];
    self.timeLab.text = model.auth_time;
    self.contentLab.text = model.title;
    self.goodsImageView.images = model.images;
    self.addressLab.text = model.position;
    self.titleView.titles = model.titles;
    self.iconImage.image = imageNamed(model.type == 1 ? @"gong" : @"qiu");
    self.countView.model = model;
    
    self.titleView.sd_layout
    .topSpaceToView(self.goodsImageView, self.model.titles.count > 0 ? 13 : 0)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(self.model.titles.count > 0 ? 15 : 0);
    
    
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
    
    
    self.countView.sd_layout
    .topSpaceToView(self.addressImageView, 0)
    .heightIs(60)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    
    [self setupAutoHeightWithBottomView:self.countView bottomMargin:0];
    
}
@end
