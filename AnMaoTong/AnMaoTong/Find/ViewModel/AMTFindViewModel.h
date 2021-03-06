//
//  AMTFindViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTFindViewModel : NSObject
@property (nonatomic, strong) RACCommand *brandCommand;
@property (nonatomic, strong) RACCommand *bannerCommand;
@property (nonatomic, strong) RACCommand *businessCommand;
@property (nonatomic, strong) RACCommand *dynamicCommand;
@property (nonatomic, strong) NSMutableArray *businessArray;
@property (nonatomic, strong) NSMutableArray *dynamicArray;
@end
