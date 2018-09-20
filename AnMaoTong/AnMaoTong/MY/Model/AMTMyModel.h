//
//  AMTMyModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTMyModel : BaseModel
@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger release_count;
@property (nonatomic, assign) NSInteger attention_count;
@property (nonatomic, assign) NSInteger collection_count;
@end
