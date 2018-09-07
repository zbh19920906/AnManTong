//
//  RegisterOneDataModel.m
//  yuexia
//
//  Created by 陈平 on 2017/12/11.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "RegisterOneDataModel.h"

@implementation RegisterOneDataModel

#pragma mark - set

#pragma mark - 生命周期

#pragma mark - Private Method

#pragma mark - Public Method

#pragma mark - get
- (RACCommand *)submitCommand{
    if (_submitCommand == nil)
        {
            weakSelf(self);
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input)
        {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber)
        {
                NSDictionary *dic = @{@"nickname":KKString(weakSelf.nickName),
                                      @"sex":@(weakSelf.sex),
                                      };
//                [CPNetTool modifUserInfoOne:dic image:weakSelf.userImage success:^(NSDictionary * _Nullable responseObject , NSURLSessionDataTask * _Nonnull task)
//        {
//                    CPLog(@"%@",responseObject);
//                    [CPAppSingle shareManager].userModel = [CPUserModel mj_objectWithKeyValues:responseObject[@"data"]];
//                    [subscriber sendNext:RACTuplePack(@(YES))];
//                    [subscriber sendCompleted];
//                } fail:^(NSString * _Nullable message, NSString *code , NSURLSessionDataTask * _Nonnull task)
//        {
//                    [subscriber sendNext:RACTuplePack(@(NO),message)];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _submitCommand;
}
@end
