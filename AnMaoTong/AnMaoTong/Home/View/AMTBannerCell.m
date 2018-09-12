//
//  AMTBannerCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTBannerCell.h"
@interface AMTBannerCell ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *  cycleScrollView;
@end
@implementation AMTBannerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.cycleScrollView];
    }
    return self;
}
- (void)setImages:(NSArray *)images
{
    self.cycleScrollView.imageURLStringsGroup = images;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
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
