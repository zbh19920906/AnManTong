//
//  AMTMyVIewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/20.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyVIewModel.h"

@implementation AMTMyVIewModel
- (instancetype)init
{
    if(self = [super init])
    {
        self.model = [[AMTMyModel alloc]init];
    }
    return self;
}

- (RACCommand *)setCountCommand
{
    if (!_setCountCommand) {
        weakSelf(self);
        _setCountCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:getCountData parameters:nil completion:^(id json, NSInteger code) {
                    NSDictionary *data = json[@"data"];
                    weakSelf.model.release_count = [data[@"release_count"] integerValue];
                    weakSelf.model.attention_count = [data[@"attention_count"] integerValue];
                    weakSelf.model.collection_count = [data[@"collection_count"] integerValue];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _setCountCommand;
}
@end
