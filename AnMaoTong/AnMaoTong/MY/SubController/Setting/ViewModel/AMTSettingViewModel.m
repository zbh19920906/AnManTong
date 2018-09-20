//
//  AMTSettingViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/20.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTSettingViewModel.h"

@implementation AMTSettingViewModel
- (RACCommand *)outLoginCommand
{
    if (!_outLoginCommand) {
        _outLoginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:outLogin parameters:nil completion:^(id json, NSInteger code) {
                    
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _outLoginCommand;
}
@end
