//
//  BHError.m
//  JIaYou
//
//  Created by lk05 on 2017/5/19.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "BHError.h"
#import "AFNetworking.h"
// 沙盒的地址
NSString * applicationDocumentsDirectory()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// 崩溃时的回调函数
void UncaughtExceptionHandler(NSException * exception)
{
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nversion:%@\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@", version,name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    // 将一个txt文件写入沙盒
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}
@implementation BHError

// 沙盒地址
- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler *)getHandler
{
    return NSGetUncaughtExceptionHandler();
}

+ (void)TakeException:(NSException *)exception
{
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason];
    NSString * name = [exception name];
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * url = [NSString stringWithFormat:@"========异常错误报告========\nversion:%@\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",  version,name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString * path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (void)requestError
{
    [self sendError];
}

#pragma mark -- 发送崩溃日志
+(void)sendError
{
    [BHError setDefaultHandler];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    //    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSString * str = [NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];

    if (str != nil) {
        [self sendExceptionLogWithData:str path:dataPath];
    }
}

+ (void)sendExceptionLogWithData:(NSString *)data path:(NSString *)path
{
//    [[KKNetWorking getShard] request:POST url:@"" parameters:@{@"errorlog":data, @"app_type": @(1)} completion:^(id json, NSInteger code) {
//        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//    } fail:^(NSString *message, NSInteger code) {
//
//    }];
}

@end
