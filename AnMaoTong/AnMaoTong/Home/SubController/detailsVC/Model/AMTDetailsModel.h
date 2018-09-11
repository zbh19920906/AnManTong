//
//  AMTDetailsModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"
#import "AMTDynamicCountModel.h"
@interface AMTDetailsModel : BaseModel
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 发布人ID
 */
@property (nonatomic, copy) NSString *user_business_id;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 图片
 */
@property (nonatomic, copy) NSString *photo;
/**
 标签ID
 */
@property (nonatomic, copy) NSString *label;
/**
 自定义标签
 */
@property (nonatomic, copy) NSString *custom_label;
/**
 发布位置
 */
@property (nonatomic, copy) NSString *position;
/**
 创建时间
 */
@property (nonatomic, copy) NSString *create_time;
/**
 审核通过时间
 */
@property (nonatomic, copy) NSString *auth_time;
/**
 动态所属的区id
 */
@property (nonatomic, copy) NSString *zone_id;
/**
 动态所属的类id
 */
@property (nonatomic, copy) NSString *goods_class_id;
/**
 动态所属的品牌id
 */
@property (nonatomic, copy) NSString *brand_id;
/**
 1:需求 2:提供
 */
@property (nonatomic, assign) NSInteger type;
/**
 是否审核通过
 */
@property (nonatomic, copy) NSString *status;
/**
 标签id转成文字
 */
@property (nonatomic, copy) NSString *label_name;
/**
 如果是type=2商户名
 */
@property (nonatomic, copy) NSString *name;
/**
 如果是type=1昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;
/**
 动态数量
 */
@property (nonatomic, strong) AMTDynamicCountModel *dynamic_num;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *titles;
@end
