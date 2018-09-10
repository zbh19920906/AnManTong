//
//  NSMutableAttributedString+Extension.m
//  yuexia
//
//  Created by 陈平 on 2017/12/5.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+(NSMutableAttributedString *)attributedWithString:(NSString *)str
                                             color:(UIColor *)color
                                              font:(UIFont *)font{
    return [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    
}

+ (NSMutableAttributedString *)cpGetAttributedStringWithlocation:(CPAttributedImageLocation)location
                                                            rect:(CGRect)rect
                                                       imageName:(NSString *)imageName
                                                           title:(NSString *)str
{
    NSMutableAttributedString *attrubuterStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = imageNamed(imageName);
    attachment.bounds = rect;
    NSAttributedString *imageAttributed = [NSAttributedString attributedStringWithAttachment:attachment];
    if (location == CPAttributedImageLocation_right)
    {
        [attrubuterStr appendAttributedString:imageAttributed];
    }
    else if (location == CPAttributedImageLocation_left)
    {
        [attrubuterStr insertAttributedString:imageAttributed atIndex:0];
    }
    return attrubuterStr;
}

// 富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color textFont:(CGFloat)font {
    NSRange hightlightTextRange = [text rangeOfString:rangeText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:BHFont(font) range:hightlightTextRange];
        return attributeStr;
    }
    else
    {
        return [rangeText copy];
    }
}

+ (NSMutableAttributedString *)createAttributedImage:(UIImage *)image bounds:(CGRect)rect
{
    NSTextAttachment *attch = [NSTextAttachment new];
    attch.image = image;
    attch.bounds = rect;
    return [NSMutableAttributedString attributedStringWithAttachment:attch];
}

@end

