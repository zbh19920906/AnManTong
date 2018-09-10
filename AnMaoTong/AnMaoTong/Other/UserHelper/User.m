//
//  User.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "User.h"

@implementation User


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    // 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
    return @{
             @"user_id" : @"id",
             };
}
@end
