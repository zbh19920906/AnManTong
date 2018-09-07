//
//  NSString+StringRegular.m
//  MeetCarefree
//
//  Created by 陈平 on 2017/11/6.
//  Copyright © 2017年 林敏. All rights reserved.
//

#import "NSString+Extension.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *) md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int) strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSString *)removeProvinceChar
{
    NSRange range = [self rangeOfString:@"省"];
    if (range.location != NSNotFound)
    {
        return [self substringFromIndex:range.location + 1];
    }
    return self;
}

+(NSString *)timeForRemaining:(NSInteger)sec{
    NSMutableString *timeStr = [NSMutableString string];
    NSInteger hour = sec / 3600;
    if (hour > 0)
        {
            [timeStr appendFormat:@"%@", [NSString stringWithFormat:@"%02ld:",hour]];
    }
    NSInteger minutes = (sec - hour * 3600) / 60;
    NSInteger secound = sec - hour * 3600 - minutes * 60;
    [timeStr appendFormat:@"%@", [NSString stringWithFormat:@"%02ld:%02ld",minutes,secound]];
    return timeStr;
}



@end
