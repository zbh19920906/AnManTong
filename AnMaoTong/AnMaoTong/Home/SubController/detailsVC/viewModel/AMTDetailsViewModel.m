//
//  AMTDetailsViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsViewModel.h"

@implementation AMTDetailsViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.listArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)detailsCommand
{
    if (!_detailsCommand) {
        weakSelf(self);
        _detailsCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:getDynamicDetails parameters:@{@"dynamic_id":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.model = [AMTDetailsModel mj_objectWithKeyValues:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(NO))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _detailsCommand;
}

- (RACCommand *)listCommand
{
    if (!_listCommand) {
        weakSelf(self);
        _listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:dynamicComment parameters:@{@"dynamic_id":input[0],@"size":requestSize,@"page":input[1]} completion:^(id json, NSInteger code) {
                    weakSelf.listArray = [AMTCommentModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:RACTuplePack(@(NO))];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _listCommand;
}

- (RACCommand *)commentCommand
{
    if (!_commentCommand) {
        weakSelf(self);
        _commentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:POST url:InsertComment parameters:@{@"dynamic_id":weakSelf.model.ID,@"content":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.model.dynamic_num.comment_count = weakSelf.model.dynamic_num.comment_count + 1;
                    
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _commentCommand;
}

- (RACCommand *)likeCommand
{
    if (!_likeCommand) {
        weakSelf(self);
        _likeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:POST url:dynamicLike parameters:@{@"dynamic_id":weakSelf.model.ID} completion:^(id json, NSInteger code) {
                    if (weakSelf.model.dynamic_num.my_like) {
                        weakSelf.model.dynamic_num.like_count = weakSelf.model.dynamic_num.like_count - 1;
                    }else{
                        weakSelf.model.dynamic_num.like_count = weakSelf.model.dynamic_num.like_count + 1;
                    }
                    weakSelf.model.dynamic_num.my_like = !weakSelf.model.dynamic_num.my_like;
                    
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _likeCommand;
}

- (RACCommand *)collectionCommand
{
    if (!_collectionCommand) {
        weakSelf(self);
        _collectionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:POST url:Collection parameters:@{@"dynamic_id":weakSelf.model.ID} completion:^(id json, NSInteger code) {
                    if (weakSelf.model.dynamic_num.my_collection) {
                       weakSelf.model.dynamic_num.collection_count = weakSelf.model.dynamic_num.collection_count - 1;
                    }else{
                        weakSelf.model.dynamic_num.collection_count = weakSelf.model.dynamic_num.collection_count + 1;
                    }
                    weakSelf.model.dynamic_num.my_collection = !weakSelf.model.dynamic_num.my_collection;
                    
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _collectionCommand;
}
@end
