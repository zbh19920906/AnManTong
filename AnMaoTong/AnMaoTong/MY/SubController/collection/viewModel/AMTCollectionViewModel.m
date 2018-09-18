//
//  AMTCollectionViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTCollectionViewModel.h"

@implementation AMTCollectionViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)collectionCommand
{
    if (!_collectionCommand) {
        weakSelf(self);
        _collectionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [[KKNetWorking getShard] request:GET url:[input[1] boolValue] ? browseRecord : myCollection  parameters:@{@"size":requestSize,@"page":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.listArr = [AMTCollectionModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _collectionCommand;
}
@end
