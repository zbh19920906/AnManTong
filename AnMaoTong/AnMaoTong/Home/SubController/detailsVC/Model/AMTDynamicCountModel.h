//
//  AMTDynamicCountModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTDynamicCountModel : BaseModel
/**
 评论数
 */
@property (nonatomic, assign) NSInteger comment_count;
/**
 点赞数
 */
@property (nonatomic, assign) NSInteger like_count;
/**
 收藏数
 */
@property (nonatomic, assign) NSInteger collection_count;
/**
 查看数
 */
@property (nonatomic, assign) NSInteger browse_count;
@end
