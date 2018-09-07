//
//  NSMutableAttributedString+FindOutNumber.m
//  CloudMoto
//
//  Created by lk05 on 2018/7/28.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "NSMutableAttributedString+FindOutNumber.h"

@implementation NSMutableAttributedString (FindOutNumber)
+(NSMutableAttributedString*)instructionAttributedString:(NSString*)instructionStr color:(NSString *)colorStr
{
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* array = [tNumRegularExpression matchesInString:instructionStr options:NSMatchingReportProgress range:NSMakeRange(0, [instructionStr length])];
    
    NSMutableAttributedString * fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:instructionStr];
    for (NSTextCheckingResult *rangeResult in array) {
        [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[UIColor cz_ToUIColorByStr:colorStr] range:rangeResult.range];
    }
    return fontAttributeNameStr;
}
@end
