//
//  ReleaseDynamicDataModel.m
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "ReleaseDynamicDataModel.h"

@interface ReleaseDynamicDataModel ()

@end


@implementation ReleaseDynamicDataModel

#pragma mark - Life
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Public


#pragma mark - Private


#pragma mark - Get
- (NSMutableArray<UIImage *> *)imageDataSource
{
    if (_imageDataSource == nil) {
        _imageDataSource = [NSMutableArray array];
    }
    return _imageDataSource;
}

- (RACCommand *)postAddUserDynamicCommand
{
    if (_postAddUserDynamicCommand == nil) {
        weakSelf(self);
        _postAddUserDynamicCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                [CPNetTool postAddUserDynamic:input models:weakSelf.imageDataSource success:^(NSDictionary * _Nullable responseObject, NSURLSessionDataTask * _Nonnull task) {
//                    CPLog(@"%@",responseObject);
//                    [subscriber sendNext:responseObject[@"data"][@"dynamic_id"]];
//                    [subscriber sendCompleted];
//                } fail:^(NSString * _Nullable message, NSString * _Nullable code, NSURLSessionDataTask * _Nonnull task) {
//                    [UIView showErrorHUD:message completeBlock:nil];
//                    [subscriber sendCompleted];
//                }];
                return nil;
            }];
        }];
    }
    return _postAddUserDynamicCommand;
}


@end

