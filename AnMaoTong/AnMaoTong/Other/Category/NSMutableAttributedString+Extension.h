//
//  NSMutableAttributedString+Extension.h
//  yuexia
//
//  Created by 陈平 on 2017/12/5.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CPAttributedImageLocation_left,
    CPAttributedImageLocation_right,
} CPAttributedImageLocation;


@interface NSMutableAttributedString (Extension)

/**
 富文本生成
 */
+(NSMutableAttributedString *)attributedWithString:(NSString *)str
                                             color:(UIColor *)color
                                              font:(UIFont *)font;

/**
 带有图标的富文本生成
 */
+ (NSMutableAttributedString *)cpGetAttributedStringWithlocation:(CPAttributedImageLocation)location
                                                            rect:(CGRect)rect
                                                       imageName:(NSString *)imageName
                                                           title:(NSString *)str;
/**
 富文本设置部分字体颜色
 */
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color textFont:(CGFloat)font;

/**
 生成图片富文本
 */
+ (NSMutableAttributedString *)createAttributedImage:(UIImage *)image bounds:(CGRect)rect;


@end
