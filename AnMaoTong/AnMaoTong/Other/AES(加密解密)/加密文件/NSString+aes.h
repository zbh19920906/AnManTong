//
//  NSString+aes.h
//  aes加密解密
//
//  Created by lk03 on 17/3/9.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (aes)
-(NSString *) aes256_encrypt:(NSInteger)type;
-(NSString *) aes256_decrypt;
@end
