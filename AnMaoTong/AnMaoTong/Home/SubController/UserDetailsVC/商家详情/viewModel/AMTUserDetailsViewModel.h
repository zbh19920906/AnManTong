//
//  AMTUserDetailsViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTUserInfoModel.h"
@interface AMTUserDetailsViewModel : NSObject
@property (nonatomic, strong) RACCommand *userInfoCommand;
@property (nonatomic, strong) RACCommand *dynamicCommand;
@property (nonatomic, strong) AMTUserInfoModel *userInfoModel;
@property (nonatomic, strong) NSMutableArray <AMTDetailsModel *>*listArray;
@end
