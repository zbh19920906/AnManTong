//
//  AMTFocusViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFocusViewModel.h"

@implementation AMTFocusViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (RACCommand *)listCommand
{
    if (!_listCommand) {
        weakSelf(self);
        _listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:myAttention parameters:@{@"size":requestSize,@"page":input[0],@"type":input[1]} completion:^(id json, NSInteger code) {
                    weakSelf.listArr = [AMTFocusModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _listCommand;
}
@end
