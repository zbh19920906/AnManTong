//
//  AMTFindViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFindViewModel.h"

@implementation AMTFindViewModel
- (RACCommand *)brandCommand
{
    if (!_brandCommand) {
        
        weakSelf(self);
        _brandCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getBrand parameters:@{@"goods_class_id":input[0]} completion:^(id json, NSInteger code) {
                    NSArray *itemArr = [AMTBrandModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[itemArr]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:@[@[]]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _brandCommand;
}

- (RACCommand *)bannerCommand
{
    if (!_bannerCommand) {
        
        weakSelf(self);
        _bannerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getCarouselMap parameters:@{@"goods_class_id":input[0]} completion:^(id json, NSInteger code) {
                    NSArray *itemArr = [AMTBannerModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[itemArr]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:@[@[]]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _bannerCommand;
}
@end
