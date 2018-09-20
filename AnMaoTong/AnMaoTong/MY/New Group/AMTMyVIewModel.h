//
//  AMTMyVIewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/20.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTMyModel.h"
@interface AMTMyVIewModel : NSObject
@property (nonatomic, strong) RACCommand *setCountCommand;
@property (nonatomic, strong) AMTMyModel *model;
@end
