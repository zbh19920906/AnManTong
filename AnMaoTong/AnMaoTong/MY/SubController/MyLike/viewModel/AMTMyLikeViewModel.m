//
//  AMTMyLikeViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyLikeViewModel.h"

@implementation AMTMyLikeViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (RACCommand *)likeCommand
{
    if (!_likeCommand) {
        weakSelf(self);
        _likeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:myLike parameters:@{@"size":requestSize,@"page":input[0]} completion:^(id json, NSInteger code) {
                    if ([input[0] integerValue] == 1) {
                        weakSelf.listArr = [AMTCollectionModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    }else{
                        [weakSelf.listArr addObjectsFromArray:[AMTCollectionModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                    }
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _likeCommand;
}

- (RACCommand *)commentCommand
{
    if (!_commentCommand) {
        weakSelf(self);
        _commentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:GET url:myComment parameters:@{@"size":requestSize,@"page":input[0]} completion:^(id json, NSInteger code) {
                    if ([input[0] integerValue] == 1) {
                        weakSelf.listArr = [AMTMyCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    }else{
                        [weakSelf.listArr addObjectsFromArray:[AMTMyCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                    }
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _commentCommand;
}
@end
