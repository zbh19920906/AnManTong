//
//  AMTSearchViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTSearchViewModel : NSObject
@property (nonatomic, strong) RACCommand *searchCommand;
@property (nonatomic, strong) RACCommand *commentCommand;
@property (nonatomic, strong) RACCommand *likeCommand;
@property (nonatomic, strong) RACCommand *collectionCommand;
//点击搜索按钮的搜索结果
@property (nonatomic, strong) NSMutableArray *searchRusltModels;
@property (nonatomic, strong) NSMutableArray *dynamicModels;
@end
