//
//  AMTHomeViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTZoneModel.h"
@interface AMTHomeViewModel : NSObject
@property (nonatomic, strong) RACCommand *classCommand;
@property (nonatomic, strong) RACCommand *listCommand;
@property (nonatomic, strong) NSMutableArray <AMTZoneModel *>*zoneArray;
@property (nonatomic, strong) NSMutableArray <AMTDetailsModel *>*listArray;
@end
