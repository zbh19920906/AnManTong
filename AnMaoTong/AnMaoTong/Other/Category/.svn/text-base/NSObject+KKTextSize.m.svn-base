//
//  NSObject+KKTextSize.m
//  JIaYou
//
//  Created by XXF on 2017/8/7.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "NSObject+KKTextSize.h"
#import <UIKit/UIKit.h>

@implementation NSObject (KKTextSize)

+(CGSize)sizeWithFont:(UIFont *)font Text:(NSString *)text MaxSize:(CGSize)maxSize{
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}

@end
