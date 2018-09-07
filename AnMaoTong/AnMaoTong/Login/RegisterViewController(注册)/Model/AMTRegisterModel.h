//
//  AMTRegisterModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTRegisterModel : BaseModel
/**
 1:用户 2:商户
 */
@property (nonatomic, copy) NSString *type;
/**
昵称(type为1时必填)
 */
@property (nonatomic, copy) NSString *nickname;
/**
性别(type为1时必填)
 */
@property (nonatomic, copy) NSString *sex;
/**
商户名称(type为2时必填)
 */
@property (nonatomic, copy) NSString *name;
/**
 微信(type为2时必填)
 */
@property (nonatomic, copy) NSString *wx;
/**
 qq(type为2时必填)
 */
@property (nonatomic, copy) NSString *qq;
/**
 商品分类(type为2时必填)
 */
@property (nonatomic, copy) NSString *goods_class_id;
@end
