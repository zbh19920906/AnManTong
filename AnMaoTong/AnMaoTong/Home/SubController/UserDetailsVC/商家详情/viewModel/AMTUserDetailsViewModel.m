//
//  AMTUserDetailsViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTUserDetailsViewModel.h"

@implementation AMTUserDetailsViewModel
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
@end
