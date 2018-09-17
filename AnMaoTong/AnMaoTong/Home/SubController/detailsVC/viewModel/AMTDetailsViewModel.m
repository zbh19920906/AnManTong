//
//  AMTDetailsViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsViewModel.h"

@implementation AMTDetailsViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)detailsCommand
{
    if (!_detailsCommand) {
        weakSelf(self);
        _detailsCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:getDynamicDetails parameters:@{@"dynamic_id":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.model = [AMTDetailsModel mj_objectWithKeyValues:json[@"data"]];
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
    return _detailsCommand;
}

- (RACCommand *)listCommand
{
    if (!_listCommand) {
        weakSelf(self);
        _listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:dynamicComment parameters:@{@"dynamic_id":input[0],@"size":@"10",@"page":input[1]} completion:^(id json, NSInteger code) {
                    weakSelf.listArray = [AMTCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
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
@end
