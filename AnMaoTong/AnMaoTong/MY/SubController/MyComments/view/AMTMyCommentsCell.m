//
//  AMTMyCommentsCell.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyCommentsCell.h"
#import "AMTMyCollectionCell.h"
@interface AMTMyCommentsCell ()
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseImageView *sexImage;
@property (nonatomic, strong) BaseLabel *ageLab;
@property (nonatomic, strong) BaseLabel *timeLab;
@property (nonatomic, strong) BaseLabel *commentLab;
@property (nonatomic, strong) AMTMyCollectionCell *goodsView;
@end
@implementation AMTMyCommentsCell

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
    self.nameLab.text = @"鸿星尔克";
    
    self.sexImage = [[BaseImageView alloc]init];
    self.sexImage.image = imageNamed(@"女性");
    
    self.ageLab = [[BaseLabel alloc]init];
    [self.ageLab setLableColor:@"CCCCCC" font:11 bold:0];
    self.ageLab.text = @"28岁";
    
    self.timeLab = [[BaseLabel alloc]init];
    [self.timeLab setLableColor:@"CCCCCC" font:10 bold:0];
    self.timeLab.text = @"2018-08-29 16:20";
    
    self.commentLab = [[BaseLabel alloc]init];
    [self.commentLab setLableColor:@"555555" font:13 bold:0];
    self.commentLab.text = @"特别的好，很喜欢";
    
    self.goodsView = [[AMTMyCollectionCell alloc]init];
    self.goodsView.backgroundColor = BHColor(@"F7F7F7");
    [self.contentView sd_addSubviews:@[self.headImage,self.nameLab,self.sexImage,self.ageLab,self.commentLab,self.timeLab,self.goodsView]];
    
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
    
    self.sexImage.sd_layout
    .topSpaceToView(self.nameLab, 11)
    .leftSpaceToView(self.headImage, 14)
    .widthIs(13)
    .heightIs(13);
    
    self.ageLab.sd_layout
    .centerYEqualToView(self.sexImage)
    .leftSpaceToView(self.sexImage, 7)
    .heightIs(11);
    [self.ageLab setSingleLineAutoResizeWithMaxWidth:300];
    
    self.timeLab.sd_layout
    .topSpaceToView(self.contentView, 24)
    .rightSpaceToView(self.contentView, 11)
    .heightIs(8);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:150];
    
    self.commentLab.sd_layout
    .topSpaceToView(self.headImage, 15)
    .leftSpaceToView(self.contentView, 11)
    .rightSpaceToView(self.contentView, 11)
    .autoHeightRatio(0)
    .maxHeightIs(34);
    
    self.goodsView.sd_layout
    .topSpaceToView(self.commentLab, 14)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(105);
    
}
@end
