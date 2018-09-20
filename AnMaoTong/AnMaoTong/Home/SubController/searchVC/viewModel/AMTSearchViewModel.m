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
@end
