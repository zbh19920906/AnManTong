//
//  AMTReleaseViewModel.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTReleaseViewModel.h"

@implementation AMTReleaseViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.zoneID = @"";
        self.brandID = @"";
    }
    return self;
}

- (RACCommand *)zoneCommand
{
    if (!_zoneCommand) {
        weakSelf(self);
        _zoneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [[KKNetWorking getShard]request:GET url:getClassZone parameters:@{@"goods_class_id" : input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.model.zoneArray = [AMTZoneModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _zoneCommand;
}

- (RACCommand *)brandCommand
{
    if (!_brandCommand) {
        weakSelf(self);
        _brandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [[KKNetWorking getShard]request:GET url:getBrand parameters:@{@"goods_class_id" : input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.model.brandArray = [AMTZoneModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _brandCommand;
}

- (RACCommand *)releaseCommand
{
    if (!_releaseCommand) {
        weakSelf(self);
        _releaseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary *dic = @{
                                      @"title":input[0],
                                      @"position":input[1],
                                      @"zone_id":input[2],
                                      @"brand_id":input[3],
                                      @"goods_class_id":input[4],
                                      @"customize_label_name":input[5],
                                      @"image":input[6],
                                      @"label_id":@""
                                      };
                [[KKNetWorking getShard]request:POST url:Release parameters:dic completion:^(id json, NSInteger code) {
                    
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _releaseCommand;
}

- (AMTClassModel *)model
{
    if (!_model) {
        _model = [[AMTClassModel alloc]init];
    }
    return _model;
}
@end
