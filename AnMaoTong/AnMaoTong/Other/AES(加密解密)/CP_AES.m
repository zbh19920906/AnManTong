//
//  CP_AES.m
//  aes加密解密
//
//  Created by lk03 on 17/3/21.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "CP_AES.h"
#import "GTMBase64.h"
#import "NSString+aes.h"
#import "NSData+aes.h"


@implementation CP_AES

/**************************************************************************************************************
                                                加密
**************************************************************************************************************/

+(NSString *)cpStringToAes256_encrypt:(NSString *)string {
    NSData *json = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [json base64EncodedStringWithOptions:0];
    return [self cpAes256_encrypt:base64String];
    
}

+(NSString *)cpDictionaryToAes256_encrypt:(NSDictionary *)dictionary{
    NSData *json = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64String = [json base64EncodedStringWithOptions:0];
    return [self cpAes256_encrypt:base64String];
}

//加密
+(NSString *)cpAes256_encrypt:(NSString *)string{
    
    return [self aes256_encrypt:string];
    
    //    return [string aes256_encrypt:type];
}

+(NSString *)aes256_encrypt:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    //对数据进行加密
    NSData * result = [data aes256_encrypt];
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

/**************************************************************************************************************
                                                解密
 **************************************************************************************************************/

+(NSString *)cpAes256_decryptToString:(NSString *)decrypt{
    NSString *base64String = [decrypt aes256_decrypt];
    return base64String;
}

+(NSDictionary *)cpAes256_decryptToDictionaty:(NSString *)decrypt{
    NSString *base64String = [decrypt aes256_decrypt];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


@end
