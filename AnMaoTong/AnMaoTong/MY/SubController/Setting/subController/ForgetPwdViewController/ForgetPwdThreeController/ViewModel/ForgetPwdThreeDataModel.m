//
//  ForgetPwdThreeDataModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdThreeDataModel.h"

@implementation ForgetPwdThreeDataModel

#pragma mark - set

#pragma mark - 生命周期

#pragma mark - Private Method

#pragma mark - Public Method

#pragma mark - get
- (RACCommand *)changePwdCommand
{
    if (_changePwdCommand == nil)
        {
        kWeakObject(self)
        _changePwdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
                kStrongObject
                NSDictionary *dic = @{@"phone":KKString(weakSelf.phone),
                                      @"password":[input[0] md5],
                                      @"repeat_password":[input[1] md5]
                                      };
                [SVProgressHUD show];
                [[KKNetWorking getShard] request:POST url:changePassword parameters:dic completion:^(id json, NSInteger code) {
                    [SVProgressHUD dismiss];
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:@[@(NO)]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _changePwdCommand;
}
@end
