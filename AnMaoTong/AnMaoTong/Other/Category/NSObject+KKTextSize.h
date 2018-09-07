//
//  NSObject+KKTextSize.h
//  JIaYou
//
//  Created by XXF on 2017/8/7.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KKTextSize)

/**
 计算文本尺寸

 @param font 字体
 @param text 文本
 @param maxSize 最大范围尺寸
 @return 尺寸
 */
+(CGSize)sizeWithFont:(UIFont *)font Text:(NSString *)text MaxSize:(CGSize)maxSize;

@end
