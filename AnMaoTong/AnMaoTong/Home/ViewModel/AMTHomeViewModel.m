//
//  AMTHomeViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHomeViewModel.h"

@implementation AMTHomeViewModel
- (RACCommand *)classCommand
{
    if (!_classCommand) {
        weakSelf(self);
        _classCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:getClassZone parameters:@{@"goods_class_id":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.zoneArray = [AMTZoneModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(NO))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _classCommand;
}

- (RACCommand *)listCommand
{
    if (!_listCommand) {
        weakSelf(self);
        _listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *dic = @{
                                      @"type" : input[0],
                                      @"goods_class_id" : input[1],
                                      @"brand_id" : input[2],
                                      @"zone_id" : input[3],
                                      @"size" : input[4],
                                      @"page" : input[5]
                                      };
                [[KKNetWorking getShard] request:GET url:getDynamic parameters:dic completion:^(id json, NSInteger code) {
                    weakSelf.listArray = [AMTDetailsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(NO))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _listCommand;
}

- (NSMutableArray *)zoneArray
{
    if (!_zoneArray) {
        _zoneArray = [[NSMutableArray alloc]init];
    }
    return _zoneArray;
}

- (NSMutableArray<AMTDetailsModel *> *)listArray
{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
@end
