//
//  ForgetPwdTwoDataModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"

@interface ForgetPwdTwoDataModel : BaseObject
/**
 登录验证
 */
@property (nonatomic , strong) RACCommand *loginCommand;
/**
 手机号
 */
@property (nonatomic , copy) NSString *phone;

@end
