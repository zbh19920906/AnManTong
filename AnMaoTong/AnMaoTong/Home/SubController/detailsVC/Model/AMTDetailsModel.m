//
//  AMTDetailsModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsModel.h"

@implementation AMTDetailsModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"dynamic_num" : AMTDynamicCountModel.class,
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
//    self.images = [self.photo componentsSeparatedByString:@"|"];
//    self.titles = [self.custom_label componentsSeparatedByString:@"|"];
    self.images = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1536638317&di=145bdb0984d3a7d778624b5f4545101e&src=http://static.oeofo.com/201610/27/131242571000812.png"];
    self.titles = @[@"一键代发",@"工厂直销",@"实体合作"];
}
@end
