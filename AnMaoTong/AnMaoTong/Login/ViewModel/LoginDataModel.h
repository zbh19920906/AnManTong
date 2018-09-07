//
//  LoginDataModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/5.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"

typedef enum : NSUInteger {
    LogineType_login,       //登录
    LogineType_register,    //注册
} LogineType;

@interface LoginDataModel : BaseObject

/**
 操作方式
 */
@property (nonatomic , assign) LogineType type;

/**
 获取验证码时间
 */
@property (nonatomic , assign) NSUInteger codeTime;

/**
 定时器是否打开
 */
@property (nonatomic , assign) BOOL isTimerOpen;

/**
 获取验证码信号
 */
@property (nonatomic , strong) RACCommand *getCodeCommand;

/**
 登录信号
 */
@property (nonatomic , strong) RACCommand *loginCommand;

/**
 注册信号
 */
@property (nonatomic , strong) RACCommand *registerCommand;

/**
 开启定时器
 */
- (void)startTimer;

/**
 关闭定时器
 */
- (void)endTimer;

@end
