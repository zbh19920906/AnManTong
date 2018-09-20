//
//  ForgetPwdThreeDataModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"

@interface ForgetPwdThreeDataModel : BaseObject

/**
 验证码
 */
@property (nonatomic , copy) NSString *code;

/**
 手机号
 */
@property (nonatomic , copy) NSString *phone;

/**
 修改密码信号
 */
@property (nonatomic , strong) RACCommand *changePwdCommand;
@end
