//
//  AMTUserInfoModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTUserInfoModel : BaseModel
/**
 昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 是否vip
 */
@property (nonatomic, copy) NSString *vip;
/**
 用户ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 是否关注
 */
@property (nonatomic, copy) NSString *is_attention;

/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;

/**
 背景图
 */
@property (nonatomic, copy) NSString *background;

/**
 性别
 */
@property (nonatomic, assign)NSInteger sex;

/**
 年龄
 */
@property (nonatomic, copy) NSString *age;

/**
 资料是否完善
 */
@property (nonatomic, copy) NSString *is_perfect;

/**
 登录时间
 */
@property (nonatomic, copy) NSString *login_time;

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
 电话
 */
@property (nonatomic, copy) NSString *phone;
/**
 用户类型
 */
@property (nonatomic, copy) NSString *type;
@end
