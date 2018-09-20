//
//  ForgetPwdOneDataModel.h
//  yuexia
//
//  Created by 陈平 on 2018/1/9.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseObject.h"

@interface ForgetPwdOneDataModel : BaseObject

@property (nonatomic , copy) NSString *phone;

/**
 获取验证码信号
 */
@property (nonatomic , strong) RACCommand *getCodeCommand;

/**
 登录验证
 */
@property (nonatomic , strong) RACCommand *loginCommand;
@end
