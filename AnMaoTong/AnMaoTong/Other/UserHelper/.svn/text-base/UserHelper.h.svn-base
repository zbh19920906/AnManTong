//
//  UserHelper.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserHelper : NSObject
@property (nonatomic, strong) User *user;

+ (instancetype)shareInstance;

+(void)savePersonalInfoToCacheWith:(NSDictionary *)dict;

/**
 修改本地的用户信息
 */
+(void)saveModifiedPersonalDetailInfoToCache;

+(void)alertToInstallWeichatOrQQClicentWithTitle:(NSString *)titleStr;

@end
