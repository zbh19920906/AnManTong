//
//  AMTCollectionModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTCollectionModel : BaseModel
/**
 id
 */
@property (nonatomic, copy) NSString *dynamic_id;
/**
 
 */
@property (nonatomic, copy) NSString *user_business_id;
/**
 1:需 2供
 */
@property (nonatomic, assign) NSInteger type;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 图片
 */
@property (nonatomic, copy) NSString *photo;
/**
 时间
 */
@property (nonatomic, copy) NSString *generate_time;
/**
 名字
 */
@property (nonatomic, copy) NSString *nickname;
/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;
/**
 是否vip
 */
@property (nonatomic, assign) BOOL vip;
@end
