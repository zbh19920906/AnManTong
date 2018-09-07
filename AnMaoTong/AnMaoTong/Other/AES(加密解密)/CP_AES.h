//
//  CP_AES.h
//  aes加密解密
//
//  Created by lk03 on 17/3/21.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CP_AES : NSObject


/**
 字符串加密
 @return 加密结果
 */
+(NSString *)cpStringToAes256_encrypt:(NSString *)string;

/**
 字典加密
 @return 加密结果
 */
+(NSString *)cpDictionaryToAes256_encrypt:(NSDictionary *)dictionary;


/**
 字符串解密
 @return 返回解密结果
 */
+(NSString *)cpAes256_decryptToString:(NSString *)decrypt;


/**
 字典解密
 @return 返回解密结果
 */
+(NSString *)cpAes256_decryptToDictionaty:(NSString *)decrypt;

@end
