//
//  AMTPersonalModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTPersonalModel : BaseModel
/**
 头像
 */
@property (nonatomic, copy) NSString *headImage_url;
/**
 用户名称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 性别
 */
@property (nonatomic, assign) NSInteger sex;
/**
 微信号
 */
@property (nonatomic, copy) NSString *wx;
/**
 qq号
 */
@property (nonatomic, copy) NSString *qq;
/**
 出生年月
 */
@property (nonatomic, copy) NSString *date_birth;
/**
 商户名称
 */
@property (nonatomic, copy) NSString *name;
/**
 公告
 */
@property (nonatomic, copy) NSString *announcement;
@end
