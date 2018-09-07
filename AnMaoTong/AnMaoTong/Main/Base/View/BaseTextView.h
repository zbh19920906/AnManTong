//
//  BaseTextView.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^limitBlock)(void);

@interface BaseTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 限制的字符 */
@property (nonatomic, assign) NSInteger kMaxNumber;

/** 超出限制回调 */
@property (nonatomic, copy) limitBlock limitBlock;

@end

