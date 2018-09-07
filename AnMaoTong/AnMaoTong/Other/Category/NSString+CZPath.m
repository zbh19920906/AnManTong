//
//  NSString+CZPath.m
//
//  Created by 刘凡 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+CZPath.h"

@implementation NSString (CZPath)

- (NSString *)cz_appendDocumentDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}
//MARK:获取沙盒
- (NSString *)cz_appendCacheDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)cz_appendTempDir {
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}
//处理数字前面的0
+(NSString*) getTheCorrectNum:(NSString*)tempString{
    while ([tempString hasPrefix:@"0"]){
        tempString = [tempString substringFromIndex:1];
    }
    return [tempString isEqualToString:@""] ? @"0" : tempString;
    
}
@end
