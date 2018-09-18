//
//  AMTPersonalVIewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalVIewModel.h"

@implementation AMTPersonalVIewModel
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

@end
