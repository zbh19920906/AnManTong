//
//  UIImage+UIImage_Base64.m
//  DouYou
//
//  Created by lk06 on 17/3/14.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "UIImage+Base64.h"

@implementation UIImage (Base64)
//MARK:base64 转成图片
+(instancetype)base64ToUIImage:(NSString *)baseStr
{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:baseStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage * decodedImage      = [UIImage imageWithData:_decodedImageData];
    
    return decodedImage;
    
}
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
