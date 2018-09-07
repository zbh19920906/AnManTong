//
//  BaseTextField.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^limitBlock)(void);
@interface BaseTextField : UITextField
/**
 光标位置
 */
@property (nonatomic, assign) CGFloat positionHeight;
/**
 限制的字符
 */
@property (nonatomic, assign) NSInteger kMaxNumber;

/**
 超出限制回调
 */
@property (nonatomic, copy) limitBlock limitBlock;
-(NSInteger)limitText:(NSString *)string
               number:(NSInteger)number;
@end
