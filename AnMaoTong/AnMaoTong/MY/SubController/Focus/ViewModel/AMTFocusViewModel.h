//
//  AMTFocusViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTFocusModel.h"
@interface AMTFocusViewModel : NSObject
@property (nonatomic, strong) RACCommand *listCommand;
@property (nonatomic, strong) NSMutableArray <AMTFocusModel *>*listArr;
@end
