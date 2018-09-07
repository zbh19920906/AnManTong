//
//  BHError.h
//  JIaYou
//
//  Created by lk05 on 2017/5/19.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHError : NSObject

/**
 添加异常
 */
+ (void)setDefaultHandler;

/**
 获取异常

 @return NSUncaughtExceptionHandler
 */
+ (NSUncaughtExceptionHandler *)getHandler;

/**
 写入异常

 @param exception 异常文件
 */
+ (void)TakeException:(NSException *)exception;

/**
 发送异常
 */
+ (void)requestError;
@end
