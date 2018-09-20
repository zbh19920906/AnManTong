//
//  AMTPersonalVIewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalVIewModel.h"

@implementation AMTPersonalVIewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.model = [[AMTPersonalModel alloc]init];
    }
    return self;
}

- (RACCommand *)headImageCommand
{
    if (!_headImageCommand) {
        _headImageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:POST url:modifyHeadImg parameters:@{@"image":@[input]} completion:^(id json, NSInteger code) {
                    [UserHelper shareInstance].user.head_img = json[@"data"][@"url"];
                    [UserHelper saveModifiedPersonalDetailInfoToCache];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _headImageCommand;
}

- (RACCommand *)saveCommand
{
    if (!_saveCommand) {
        weakSelf(self);
        _saveCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:POST url:modifyData parameters:[weakSelf.model mj_keyValues] completion:^(id json, NSInteger code) {
                    [UserHelper shareInstance].user.wx = weakSelf.model.wx;
                    [UserHelper shareInstance].user.qq = weakSelf.model.qq;
                    [UserHelper shareInstance].user.date_birth = weakSelf.model.date_birth;
                    [UserHelper shareInstance].user.sex = weakSelf.model.sex;
                    [UserHelper shareInstance].user.nickname = weakSelf.model.nickname;
                    [UserHelper shareInstance].user.name = weakSelf.model.name;
                    [UserHelper shareInstance].user.announcement = weakSelf.model.announcement;
                    [UserHelper shareInstance].user.age = json[@"data"][@"age"];
                    [UserHelper saveModifiedPersonalDetailInfoToCache];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _saveCommand;
}
@end
