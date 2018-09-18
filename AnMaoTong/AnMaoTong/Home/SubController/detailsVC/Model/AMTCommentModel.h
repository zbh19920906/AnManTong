//
//  AMTCommentModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTCommentModel : BaseModel
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 评论人id
 */
@property (nonatomic, copy) NSString *user_id;
/**
 回复人ID
 */
@property (nonatomic, copy) NSString *reply_user_id;
/**
 回复人类型(1或2)
 */
@property (nonatomic, assign) NSInteger reply_user_type;
/**
 动态id
 */
@property (nonatomic, copy) NSString *dynamic_id;
/**
 是否点赞过
 */
@property (nonatomic, assign) BOOL is_comment_like_count;
/**
 回复内容
 */
@property (nonatomic, copy) NSString *content;
/**
 回复的评论id
 */
@property (nonatomic, copy) NSString *parent_id;
/**
 时间
 */
@property (nonatomic, copy) NSString *generate_time;
/**
  1已读，0未读
 */
@property (nonatomic, assign) BOOL is_read;
/**
 评论人类型(1或2)
 */
@property (nonatomic, assign) NSInteger type;
/**
 评论点赞数
 */
@property (nonatomic, assign) NSInteger comment_like_count;
/**
 回复人昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 评论人vip
 */
@property (nonatomic, copy) NSString *parent_nickname_vip;
/**
 头像
 */
@property (nonatomic, copy) NSString *head_img;
/**
 评论人昵称
 */
@property (nonatomic, copy) NSString *parent_nickname;
@end
