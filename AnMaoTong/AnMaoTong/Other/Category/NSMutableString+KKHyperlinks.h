//
//  NSMutableString+KKHyperlinks.h
//  CloudMoto
//
//  Created by lk05 on 2018/8/9.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (KKHyperlinks)
#pragma mark - 获取链接的位置
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
#pragma mark - 获取链接
+ (NSMutableArray *)getURLFromStr:(NSString *)string;
@end
