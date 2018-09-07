//
//  BaseModel.m
//  baseModel
//
//  Created by lk05 on 2018/5/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([BaseModel isEmpty:oldValue] && [property.type.typeClass isKindOfClass:[NSString class]]) {
        return  @"";
    }
    return oldValue;
}

+ (BOOL)isEmpty:(NSString*)text
{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]]) {
        return YES;
    }
    else if (text == nil) {
        return YES;
    }
    return NO;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    // 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
    return @{
             @"ID" : @"id",
             };
}
@end
