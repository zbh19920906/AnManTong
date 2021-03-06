//
//  AMTHeadInfoView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHeadInfoView.h"
#import "AMTHeadItemView.h"
@interface AMTHeadInfoView ()
@property (nonatomic, strong) AMTHeadItemView *sendCount;
@property (nonatomic, strong) AMTHeadItemView *focusCount;
@property (nonatomic, strong) AMTHeadItemView *collectionCount;
@end
@implementation AMTHeadInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    self.sendCount = [[AMTHeadItemView alloc]init];
    self.sendCount.contentLab.text = @"发布";
    self.sendCount.tag = 1;
    
    self.focusCount = [[AMTHeadItemView alloc]init];
    self.focusCount.contentLab.text = @"关注";
    self.focusCount.tag = 2;
    
    self.collectionCount = [[AMTHeadItemView alloc]init];
    self.collectionCount.contentLab.text = @"收藏";
    self.collectionCount.tag = 3;
    [self sd_addSubviews:@[self.sendCount,self.focusCount,self.collectionCount]];
    
    self.sendCount.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 43)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.collectionCount.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, 43)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.focusCount.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .widthIs(40)
    .heightEqualToWidth();
}

- (void)setModel:(AMTMyModel *)model
{
    self.sendCount.titleLab.text = BHIString(model.release_count);
    self.collectionCount.titleLab.text = BHIString(model.collection_count);
    self.focusCount.titleLab.text = BHIString(model.attention_count);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
