//
//  User.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**
 昵称
 */
@property (nonatomic, copy) NSString *nickname;

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
@property (nonatomic, copy) NSString *mobile;

/**
 性别
 */
@property (nonatomic, copy) NSString *sex;

/**
 年龄
 */
@property (nonatomic, copy) NSString *age;

/**
 默认支付方式
 */
@property (nonatomic, copy) NSString *default_payment;

/**
 纬度
 */
@property (nonatomic, copy) NSString *lat;

/**
 经度
 */
@property (nonatomic, copy) NSString *lon;

/**
 是否上一次用户未登录状态的标志，0 未登录；1 在登录状态
 */
@property (nonatomic, assign) int is_last_time_login_flag;

/**
 是否是商家标志，0 否；1 是
 */
@property (nonatomic, assign) int is_business_flag;

/**
 代金券总数
 */
@property (nonatomic, copy) NSString *coupon_count;

/**
 商家代金券总数
 */
@property (nonatomic, copy) NSString *business_coupon_count;

/**
 账户余额
 */
@property (nonatomic, copy) NSString *account_balance;
/**
 红包剩余时间
 */
@property (nonatomic, copy) NSString *red_packet_time_left;
/**
 H5 token：用户id通过AES加密获取
 */
@property (nonatomic, copy) NSString *mallToken;

/**
 是否有新代金券
 */
@property (nonatomic, assign) BOOL coupons_show_flag;

/**
 是否设置支付密码标志
 */
@property (nonatomic, assign) BOOL is_set_payment_password_flag;

/**
 商家店铺名称
 */
@property (nonatomic, copy) NSString *store_name;
/**
赚取的兜币数额
 */
@property (nonatomic, copy) NSString *received_pocket_money_amount;
/**
 已抢红包金额
 */
@property (nonatomic, copy) NSString *received_red_packet_money_amount;
/**
 动态数量
 */
@property (nonatomic, copy) NSString *action_count;
/**
 关注数量
 */
@property (nonatomic, copy) NSString *attention_count;
/**
  粉丝数量
 */
@property (nonatomic, copy) NSString *fans_count;
/**
 消费的兜币数额
 */
@property (nonatomic, copy) NSString *payment_pocket_money_amount;
//社交用户 uuid
@property (nonatomic, copy) NSString *social_uuid;
//社交用户ID
@property (nonatomic, copy) NSString *social_user_id;
//社交用户头像
@property (nonatomic, copy) NSString *social_head_img;
//社交用户名
@property (nonatomic, copy) NSString *social_username;
//社交用户密码
@property (nonatomic, copy) NSString *social_password;
//朋友圈封面
@property (nonatomic, copy) NSString *social_moments_cover_img;

//是否隐藏红点
@property (nonatomic, assign) BOOL isHiddenRedCount;

//get_new_user_red_packet_money 成功获得新人红包的金额（大于0就是领取成功）
@property (nonatomic, copy) NSString *get_new_user_red_packet_money;
//get_coopen_red_packet_money 成功获得开屏红包的金额（大于0就是领取成功）
@property (nonatomic, copy) NSString *get_coopen_red_packet_money;

/**
 剩余零钱
 */
@property (nonatomic, copy) NSString *surplus_amount;
/**
 赚取的零钱
 */
@property (nonatomic, copy) NSString *received_amount;
/**
 消费的零钱
 */
@property (nonatomic, copy) NSString *payment_amount;
@end
