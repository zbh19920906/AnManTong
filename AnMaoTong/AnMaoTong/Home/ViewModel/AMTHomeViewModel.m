//
//  AMTHomeViewModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHomeViewModel.h"

@implementation AMTHomeViewModel
- (RACCommand *)classCommand
{
    if (!_classCommand) {
        weakSelf(self);
        _classCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard] request:GET url:getClassZone parameters:@{@"goods_class_id":input[0]} completion:^(id json, NSInteger code) {
                    weakSelf.zoneArray = [AMTZoneModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _classCommand;
}

- (RACCommand *)listCommand
{
    if (!_listCommand) {
        weakSelf(self);
        _listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *dic = @{
                                      @"type" : input[0],
                                      @"goods_class_id" : input[1],
                                      @"brand_id" : input[2],
                                      @"zone_id" : input[3],
                                      @"size" : requestSize,
                                      @"page" : input[4]
                                      };
                [[KKNetWorking getShard] request:GET url:getDynamic parameters:dic completion:^(id json, NSInteger code) {
                    weakSelf.listArray = [AMTDetailsModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:RACTuplePack(@(YES))];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
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
            AMTDetailsModel *model = input[0];
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[KKNetWorking getShard]request:POST url:InsertComment parameters:@{@"dynamic_id":model.ID,@"content":input[1]} completion:^(id json, NSInteger code) {
                    model.dynamic_num.comment_count = model.dynamic_num.comment_count + 1;
                    NSInteger index =  [weakSelf.listArray indexOfObject:model];
                    [weakSelf.listArray replaceObjectAtIndex:index withObject:model];
                    
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
                    
                    NSInteger index =  [weakSelf.listArray indexOfObject:model];
                    [weakSelf.listArray replaceObjectAtIndex:index withObject:model];
                    
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
                    
                    NSInteger index =  [weakSelf.listArray indexOfObject:model];
                    if (index != 0x7FFFFFFFFFFFFFFF) {
                        [weakSelf.listArray replaceObjectAtIndex:index withObject:model];
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

- (RACCommand *)bannerCommand
{
    if (!_bannerCommand) {
        
        weakSelf(self);
        _bannerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSArray *inputs = input;
                [[KKNetWorking getShard]request:GET url:getCarouselMap parameters:@{@"goods_class_id":input[0],@"carousel_type":input[1],@"zone_id":inputs.count > 2 ? input[2] : @""} completion:^(id json, NSInteger code) {
                    weakSelf.images = [AMTBannerModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _bannerCommand;
}

- (NSMutableArray *)zoneArray
{
    if (!_zoneArray) {
        _zoneArray = [[NSMutableArray alloc]init];
    }
    return _zoneArray;
}

- (NSMutableArray<AMTBannerModel *> *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
}

- (NSMutableArray<AMTDetailsModel *> *)listArray
{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
@end
