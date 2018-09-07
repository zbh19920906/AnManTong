//
//  RegisterOneDataModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/11.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"

@interface RegisterOneDataModel : BaseObject

/**
 用户头像
 */
@property (nonatomic , strong) UIImage *userImage;

/**
 性别
 */
@property (nonatomic , assign) NSInteger sex;

/**
 昵称
 */
@property (nonatomic , copy) NSString *nickName;

/**
 数据上传信号
 */
@property (nonatomic , strong) RACCommand *submitCommand;

@end
