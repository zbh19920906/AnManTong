//
//  UIImage+Extension.m
//  JIaYou
//
//  Created by XXF on 2017/6/26.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithCircleBorderW:(CGFloat)borderW circleColor:(UIColor *)circleColor image:(UIImage *)image
{
//    // 圆环宽度
//    CGFloat borderWH = borderW;
//    
//    // 加载图片
//    // UIImage *image = [UIImage imageNamed:imageName];
//    
//    CGFloat ctxWH = image.size.width + 2 * borderWH;
//    
//    CGRect ctxRect = CGRectMake(0, 0, ctxWH, ctxWH);
//    
//    // 1.开启位图上下文
//    UIGraphicsBeginImageContextWithOptions(ctxRect.size, YES, 0);
//    
//    // 2.画大圆
//    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:ctxRect];
//    
//    // 设置圆环的颜色
//    [circleColor set];
//    [circleColor setFill];
//    
//    [bigCirclePath fill];
//    
//    // 3.设置裁剪区域
//    CGRect clipRect = CGRectMake(borderWH, borderWH, ctxWH - 2, ctxWH - 2);
//    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipRect];
//    [clipPath addClip];
//    
//    //4.画图片
//    [image drawAtPoint:CGPointMake(borderWH, borderWH)];
//    
//    // 5.从上下文中获取图片
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 6.关闭上下文
//    UIGraphicsEndImageContext();
    CGPoint  point = CGPointZero;
    CGRect rect = CGRectMake(point.x, point.y, borderW, borderW);
    
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    [UIColor.clearColor setFill];
    UIRectFill(rect);
    
    // 2.画大圆
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [bigCirclePath addClip];
    
    [image drawInRect:rect];
    

    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


//图片压缩
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength
{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    
    if (data.length < maxLength)
        return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
            
        } else if (data.length > maxLength) {
            max = compression;
            
        } else {
            break;
            
        }
    }
    return data;
}

// 缩放图片至新尺寸
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    if (image.size.width > size.width) {
        CGImageRef sourceImageRef = [image CGImage];
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, 0, size.width, size.height));
        UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        return newImage;

    } else {
        return image;
    }
}

+(UIImage *)scaleToSize:(UIImage *)aImage size:(CGSize)size{
    
    //创建context,并将其设置为正在使用的context
    UIGraphicsBeginImageContext(size);
    //绘制出图片(大小已经改变)
    [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //获取改变大小之后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //context出栈
    UIGraphicsEndImageContext();
    return newImage; //返回获得的图片
}

+ (UIImage *)imageRotation:(UIImage *)image//屏幕横竖屏的图片转换
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
            
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

+ (UIImage *)imageRotation2:(UIImage *)image//屏幕横竖屏的图片转换
{
    if (image.size.width < image.size.height) {
        return image;
    }
    long double rotate = 3 * M_PI_2;
    CGRect rect =  CGRectMake(0, 0, image.size.height, image.size.width);
    float translateX = -rect.size.height;
    float translateY = 0;
    float scaleX = rect.size.height/rect.size.width;
    float scaleY = rect.size.width/rect.size.height;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
@end
