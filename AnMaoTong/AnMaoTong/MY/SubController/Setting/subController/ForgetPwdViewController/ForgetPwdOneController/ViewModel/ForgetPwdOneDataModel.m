//
//  ForgetPwdOneDataModel.m
//  yuexia
//
//  Created by 陈平 on 2018/1/9.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "ForgetPwdOneDataModel.h"

@interface ForgetPwdOneDataModel ()

@end

@implementation ForgetPwdOneDataModel

#pragma mark - Life


#pragma mark - Pravite


#pragma mark - Public


#pragma mark - get
- (RACCommand *)getCodeCommand{
    if (_getCodeCommand == nil)
    {
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){
                [SVProgressHUD show];
                [[KKNetWorking getShard] request:GET url:getCode parameters:@{@"phone":KKString(input),@"type":@"2"} completion:^(id json, NSInteger code) {
                    [SVProgressHUD dismiss];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _getCodeCommand;
}


- (RACCommand *)loginCommand{
    if (_loginCommand == nil)
    {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input){
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber){

//                [[KKNetWorking getShard] request:GET url:getCode parameters:@{@"phone":KKString(input),@"type":@"1"} completion:^(id json, NSInteger code) {
//                    [SVProgressHUD dismiss];
//                    [subscriber sendNext:RACTuplePack(@(YES))];
//                    [subscriber sendCompleted];
//                } fail:^(NSString *message, NSInteger code) {
//
//                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

@end

