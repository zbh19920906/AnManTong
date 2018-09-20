//
//  AMTUserDetailsViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTUserDetailsViewModel.h"

@implementation AMTUserDetailsViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)userInfoCommand
{
    if (!_userInfoCommand) {
        weakSelf(self);
        _userInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getUserDetails parameters:@{@"user_id":input[0],@"type":input[1]} completion:^(id json, NSInteger code) {
                    weakSelf.userInfoModel = [AMTUserInfoModel mj_objectWithKeyValues:json[@"data"]];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _userInfoCommand;
}

- (RACCommand *)dynamicCommand
{
    if (!_dynamicCommand) {
        weakSelf(self);
        _dynamicCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:getBusinessDynamic parameters:@{@"size":requestSize,@"page":input[0],@"id":input[1],@"type":input[2]} completion:^(id json, NSInteger code) {
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
    return _dynamicCommand;
}
@end
