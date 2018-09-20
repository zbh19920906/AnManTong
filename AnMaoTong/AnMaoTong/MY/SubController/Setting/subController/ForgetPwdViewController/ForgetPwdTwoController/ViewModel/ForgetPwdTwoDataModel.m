//
//  ForgetPwdTwoDataModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ForgetPwdTwoDataModel.h"

@implementation ForgetPwdTwoDataModel

#pragma mark - set

#pragma mark - 生命周期

#pragma mark - Private Method

#pragma mark - Public Method

#pragma mark - get
- (RACCommand *)loginCommand{
    if (_loginCommand == nil)
    {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
        
                [[KKNetWorking getShard] request:POST url:checkCode parameters:@{@"phone":input[0],@"code":input[1]} completion:^(id json, NSInteger code) {
                    [SVProgressHUD dismiss];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}
@end
