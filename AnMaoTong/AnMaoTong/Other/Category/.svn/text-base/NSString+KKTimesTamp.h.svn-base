//
//  NSString+KKTimesTamp.h
//  CloudMoto
//
//  Created by xxf on 2018/3/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KKTimesTamp)

//时间格式为今天昨天
+ (NSString *)smartFormat:(NSString *)string;

/**
 获取当前的时间戳

 @return 时间戳
 */
+(NSInteger)getNowTimestamp;

+(NSString *)getNowTimeTimestamp2;

/**
 获取某个时间为周几

 @param date 时间日期
 @return 周几
 */
+ (NSString *)calculateWeek:(NSDate *)date;

/**
 将某个时间转化成 时间戳

 @param formatTime 时间
 @param format 时间格式
 @return 时间戳
 */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 将某个时间戳转化成 时间

 @param timestamp 时间戳
 @param format 时间格式
 @return 时间格式的时间
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;

+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)month:(NSDate *)date;

+ (NSInteger)day:(NSDate *)date;

/**
 秒转为天时分

 @param seconds 秒
 @return xx天xx时xx分
 */
+ (NSString *)conversionTime:(NSInteger)seconds;
@end
