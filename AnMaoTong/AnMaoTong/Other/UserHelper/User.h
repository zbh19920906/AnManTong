//
//  User.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : BaseModel

/**
 昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 车牌
 */
@property (nonatomic, copy) NSString *number;
/**
 用户ID
 */
@property (nonatomic, copy) NSString *user_id;

/**
 令牌
 */
@property (nonatomic, copy) NSString *token;

/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;

/**
 手机号
 */
@property (nonatomic, copy) NSString *phone;

/**
 性别
 */
@property (nonatomic, copy) NSString *sex;

/**
 年龄
 */
@property (nonatomic, copy) NSString *age;

/**
 纬度
 */
@property (nonatomic, copy) NSString *lat;

/**
 经度
 */
@property (nonatomic, copy) NSString *lon;

/**
 密码
 */
@property (nonatomic, copy) NSString *password;
/**
 商户名称
 */
@property (nonatomic, copy) NSString *name;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *contact;

/**
 商品名称
 */
@property (nonatomic, copy) NSString *class_name;
/**
 公告
 */
@property (nonatomic, copy) NSString *announcement;
/**
 商家认证
 */
@property (nonatomic, copy) NSString *is_auth;
/**
 微信号
 */
@property (nonatomic, copy) NSString *wx;
/**
 qq号
 */
@property (nonatomic, copy) NSString *qq;
/**
登录时间
 */
@property (nonatomic, copy) NSString *login_time;
/**
 用户类型
 */
@property (nonatomic, copy) NSString *type;
@end
