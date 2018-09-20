//
//  AMTFocusModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTFocusModel : BaseModel
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 名字
 */
@property (nonatomic, copy) NSString *name;
/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;
/**
 QQ号
 */
@property (nonatomic, copy) NSString *qq;
/**
 微信号
 */
@property (nonatomic, copy) NSString *wx;
/**
 是否关注
 */
@property (nonatomic, assign) BOOL is_attention;
/**
 关注的类型 1:用户 2:商户
 */
@property (nonatomic, copy) NSString *type;

/**
 年龄
 */
@property (nonatomic, assign) NSInteger age;
/**
 性别
 */
@property (nonatomic, assign) NSInteger sex;
@end
