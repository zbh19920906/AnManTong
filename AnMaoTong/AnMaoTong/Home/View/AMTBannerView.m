//
//  AMTBannerView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTBannerView.h"
@interface AMTBannerView ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *  cycleScrollView;
@end
@implementation AMTBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    self.cycleScrollView.imageURLStringsGroup = images;
}

//图片轮播视图
-(SDCycleScrollView*)cycleScrollView
{
    if (!_cycleScrollView) {
        // 网络加载图片的轮播器
        _cycleScrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 188) delegate:self placeholderImage:imageNamed(@"banner_empty")];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
@end
