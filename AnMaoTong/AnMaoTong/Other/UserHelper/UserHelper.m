//
//  UserHelper.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "UserHelper.h"
static UserHelper *_instance = nil;
@implementation UserHelper
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            
        }
    });
    return _instance;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
            [_instance getPersonalInfoFromCache];
        }
    });
    return _instance;
}

+(void)saveModifiedPersonalDetailInfoToCache{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *tempDict = _instance.user.mj_keyValues;
    [userDefault setObject:tempDict forKey:PersonalInfo];
    [userDefault synchronize];
    
}

//提取本地数据
- (void)getPersonalInfoFromCache
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [userDefault objectForKey:PersonalInfo];
    _instance.user = [User mj_objectWithKeyValues:userDict];
}

//存入本地
+(void)savePersonalInfoToCacheWith:(NSDictionary *)dict
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    User *userInfo = [User mj_objectWithKeyValues:dict];
    NSDictionary *tempDict = userInfo.mj_keyValues;
    [userDefault setObject:tempDict forKey:PersonalInfo];
    
    NSString *mallToken = @"";
    if (userInfo.user_id.length > 0) {
        mallToken = [CP_AES cpStringToAes256_encrypt:userInfo.user_id];
        [userDefault setObject:mallToken forKey:kMallToken];
    } else {
        [userDefault removeObjectForKey:kMallToken];
    }
    
    [userDefault synchronize];
    _instance.user = userInfo;
    _instance.user.mallToken = mallToken;
}

+(void)alertToInstallWeichatOrQQClicentWithTitle:(NSString *)titleStr
{
    if ([[UserHelper shareInstance].user.user_id isEqualToString:@"1203"]) {
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:titleStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [getWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
