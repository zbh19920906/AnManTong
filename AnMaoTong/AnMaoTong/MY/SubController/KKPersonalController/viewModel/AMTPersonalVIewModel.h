//
//  AMTPersonalVIewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTPersonalModel.h"
@interface AMTPersonalVIewModel : NSObject
@property (nonatomic, strong) AMTPersonalModel *model;
@property (nonatomic, strong) RACCommand *headImageCommand;
@end
