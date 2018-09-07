//
//  UIImage+Extension.h
//  JIaYou
//
//  Created by XXF on 2017/6/26.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//圆角加边框
+(UIImage *)imageWithCircleBorderW:(CGFloat)borderW circleColor:(UIColor *)circleColor image:(UIImage *)image;

//图片压缩
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

// 缩放图片至新尺寸
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage *)scaleToSize:(UIImage *)aImage size:(CGSize)size;
+ (UIImage *)imageRotation:(UIImage *)image;
+ (UIImage *)imageRotation2:(UIImage *)image;
@end
