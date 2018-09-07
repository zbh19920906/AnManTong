//
//  AMTDetailsModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTDetailsModel : BaseModel
/**
 名字
 */
@property (nonatomic, copy) NSString *name;
/**
 头像
 */
@property (nonatomic, copy) NSString *headImage;
/**
 时间
 */
@property (nonatomic, copy) NSString *time;
/**
 内容
 */
@property (nonatomic, copy) NSString *content;
/**
 地址
 */
@property (nonatomic, copy) NSString *address;
/**
 评论数
 */
@property (nonatomic, copy) NSString *commentsNum;
/**
 点赞数
 */
@property (nonatomic, copy) NSString *likeNum;
/**
 收藏数
 */
@property (nonatomic, copy) NSString *collectionNum;
/**
 查看数
 */
@property (nonatomic, copy) NSString *watchNum;
/**
 图片数
 */
@property (nonatomic, copy) NSArray *images;
@end
