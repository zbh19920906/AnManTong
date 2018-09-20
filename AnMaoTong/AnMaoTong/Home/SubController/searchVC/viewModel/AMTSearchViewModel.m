//
//  AMTSearchViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTSearchViewModel.h"

@implementation AMTSearchViewModel
- (instancetype)init
{
    if (self = [super init]) {
        self.searchRusltModels = [[NSMutableArray alloc]init];
        self.dynamicModels = [[NSMutableArray alloc]init];
    }
    return self;
}

- (RACCommand *)searchCommand
{
    if (!_searchCommand) {
        weakSelf(self);
        _searchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:Search parameters:@{@"size":requestSize,@"page":input[0],@"search_type":input[1],@"content":input[2]} completion:^(id json, NSInteger code) {
                    NSInteger search_type = [input[1] integerValue];
                    if ([input[0] integerValue] == 1) {
                        if (search_type == 1) {
                            weakSelf.dynamicModels = [AMTDetailsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                        }else{
                            weakSelf.searchRusltModels = [AMTFocusModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                        }
                    }else{
                        if (search_type == 1) {
                            [weakSelf.dynamicModels addObjectsFromArray:[AMTDetailsModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                        }else{
                            [weakSelf.searchRusltModels addObjectsFromArray:[AMTFocusModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
                        }
                    }
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _searchCommand;
}

- (RACCommand *)commentCommand
{
    if (!_commentCommand) {
        weakSelf(self);
        _commentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            AMTDetailsModel *model = input[0];
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:POST url:InsertComment parameters:@{@"dynamic_id":model.ID,@"content":input[1]} completion:^(id json, NSInteger code) {
                    model.dynamic_num.comment_count = model.dynamic_num.comment_count + 1;
                    NSInteger index =  [weakSelf.dynamicModels indexOfObject:model];
                    [weakSelf.dynamicModels replaceObjectAtIndex:index withObject:model];
                    
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
                AMTDetailsModel *model = input;
                [[KKNetWorking getShard]request:POST url:dynamicLike parameters:@{@"dynamic_id":model.ID} completion:^(id json, NSInteger code) {
                    if (model.dynamic_num.my_like) {
                        model.dynamic_num.like_count = model.dynamic_num.like_count - 1;
                    }else{
                        model.dynamic_num.like_count = model.dynamic_num.like_count + 1;
                    }
                    model.dynamic_num.my_like = !model.dynamic_num.my_like;
                    
                    NSInteger index =  [weakSelf.dynamicModels indexOfObject:model];
                    [weakSelf.dynamicModels replaceObjectAtIndex:index withObject:model];
                    
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
                AMTDetailsModel *model = input;
                [[KKNetWorking getShard]request:POST url:Collection parameters:@{@"dynamic_id":model.ID} completion:^(id json, NSInteger code) {
                    if (model.dynamic_num.my_collection) {
                        model.dynamic_num.collection_count = model.dynamic_num.collection_count - 1;
                    }else{
                        model.dynamic_num.collection_count = model.dynamic_num.collection_count + 1;
                    }
                    model.dynamic_num.my_collection = !model.dynamic_num.my_collection;
                    
                    NSInteger index =  [weakSelf.dynamicModels indexOfObject:model];
                    if (index != 0x7FFFFFFFFFFFFFFF) {
                        [weakSelf.dynamicModels replaceObjectAtIndex:index withObject:model];
                    }
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
