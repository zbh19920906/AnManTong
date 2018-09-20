//
//  AMTFindViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFindViewModel.h"

@implementation AMTFindViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.businessArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)brandCommand
{
    if (!_brandCommand) {
        _brandCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getBrand parameters:@{@"goods_class_id":input[0]} completion:^(id json, NSInteger code) {
                    NSArray *itemArr = [AMTBrandModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[itemArr]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
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
        _bannerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getCarouselMap parameters:@{@"goods_class_id":input[0],@"carousel_type":input[1]} completion:^(id json, NSInteger code) {
                    NSArray *itemArr = [AMTBannerModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[itemArr]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _bannerCommand;
}

- (RACCommand *)businessCommand
{
    if (!_businessCommand) {
        
        weakSelf(self);
        _businessCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getBrandBusiness parameters:@{@"size": requestSize,@"page":input[0],@"goods_class_id":input[1],@"brand_id":input[2]} completion:^(id json, NSInteger code) {
                    if ([input[0] integerValue] == 1) {
                        weakSelf.businessArray = [AMTFocusModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    }else{
                        [weakSelf.businessArray addObjectsFromArray:[AMTFocusModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                    }
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _businessCommand;
}


- (RACCommand *)dynamicCommand
{
    if (!_dynamicCommand) {
        
        weakSelf(self);
        _dynamicCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getDynamicBrandBusiness parameters:@{@"size": requestSize,@"page":input[0],@"goods_class_id":input[1],@"brand_id":input[2]} completion:^(id json, NSInteger code) {
                    if ([input[0] integerValue] == 1) {
                        weakSelf.dynamicArray = [AMTCollectionModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    }else{
                        [weakSelf.dynamicArray addObjectsFromArray:[AMTCollectionModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                    }
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _dynamicCommand;
}

@end
