//
//  NSMutableString+KKHyperlinks.m
//  CloudMoto
//
//  Created by lk05 on 2018/8/9.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "NSMutableString+KKHyperlinks.h"

@implementation NSMutableString (KKHyperlinks)
#pragma mark - 获取链接的位置
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    if (findText == nil && [findText isEqualToString:@""]){
        return nil;
    }
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    if (
        rang.location != NSNotFound && rang.length != 0){
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++){
            if (0 == i){
                //去掉这个abc字符串
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }else{
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            //在一个range范围内查找另一个字符串的range
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0){
                break;
            }
            else//添加符合条件的location进数组
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return arrayRanges;
    }
    return nil;
}
#pragma mark - 获取链接
+ (NSMutableArray *)getURLFromStr:(NSString *)string {
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string
                                                options:0
                                                  range:NSMakeRange(0, [string length])];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        
        [arr addObject:substringForMatch];
    }
    
    return arr;
}
@end
