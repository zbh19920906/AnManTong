//
//  AMTGoodsImageView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTGoodsImageView.h"
@interface AMTGoodsImageView ()
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) BaseButton *maskBtn;
@end
@implementation AMTGoodsImageView

- (instancetype)init
{
    if (self = [super init]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.imageViews = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < 3 ;i ++) {
        BaseImageView *image = [[BaseImageView alloc]init];
        image.hidden = YES;
        image.sd_cornerRadius = @(4);
        [self addSubview:image];
        [self.imageViews addObject:image];
    }
    
    _maskBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    _maskBtn.backgroundColor = [UIColor blackColor];
    _maskBtn.alpha = 0.3;
    _maskBtn.sd_cornerRadius = @(4);
    _maskBtn.hidden = YES;
    [self addSubview:_maskBtn];
    _maskBtn.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, 11)
    .topEqualToView(self)
    .widthIs((WIDTH_SCREEN - 37)/3);
}

- (void)setImages:(NSArray *)images
{
    _maskBtn.hidden = images.count <= 3 ? YES : NO;
    for (NSInteger i = images.count; i < self.imageViews.count; i ++) {
        BaseImageView *image = self.imageViews[i];
        image.hidden = YES;
    }
    for (NSInteger i = 0; i < (images.count > 3 ? 3 : images.count); i ++) {
        BaseImageView *image = self.imageViews[i];
        image.hidden = NO;
        [image sd_setImageWithURL:UrlString(images[i])];
        image.frame = CGRectMake(((WIDTH_SCREEN - 37)/3 + 8) * i + 10, 0, (WIDTH_SCREEN - 37)/3, (WIDTH_SCREEN - 37)/3);
    }
}
@end
