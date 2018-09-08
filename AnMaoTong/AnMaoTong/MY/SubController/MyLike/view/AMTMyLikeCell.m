//
//  AMTMyLikeCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/8.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyLikeCell.h"

#import "AMTMyCollectionCell.h"
@interface AMTMyLikeCell ()
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) AMTMyCollectionCell *goodsView;
@end
@implementation AMTMyLikeCell

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
    self.headImage.backgroundColor = [UIColor redColor];
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FF3658" font:13 bold:0];
    self.nameLab.text = @"我 赞了这篇内容";
    
    self.goodsView = [[AMTMyCollectionCell alloc]init];
    self.goodsView.backgroundColor = BHColor(@"F7F7F7");
    [self.contentView sd_addSubviews:@[self.headImage,self.nameLab,self.goodsView]];
    
    self.headImage.sd_layout
    .topSpaceToView(self.contentView, 18)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .topSpaceToView(self.contentView, 23)
    .leftSpaceToView(self.headImage, 10)
    .heightIs(13);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.goodsView.sd_layout
    .topSpaceToView(self.headImage, 15)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(105);
    
}

@end
