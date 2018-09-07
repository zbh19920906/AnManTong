//
//  NSString+KKPhoneNumber.m
//  CloudMoto
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "NSString+KKPhoneNumber.h"

@implementation NSString (KKPhoneNumber)

+ (NSString *)formatPhoneNum:(NSString *)phone
{
    //去掉中间空格
    phone = [[phone componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    //去掉-
    if ([phone containsString:@"-"]) {
        NSArray *arr = [phone componentsSeparatedByString:@"-"];
        NSMutableString *strNum = [NSMutableString string];
        for (NSString *str in arr) {
            [strNum appendString:str];
        }
        phone = strNum;
    }
    //+86
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}

@end
