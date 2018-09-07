//
//  UIBarButtonItem+KKExtension.m
//  CloudHome
//
//  Created by lk03 on 2017/9/14.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "UIBarButtonItem+KKExtension.h"
#import "BaseButton.h"

@implementation UIBarButtonItem (KKExtension)
+ (instancetype)barButtonItemComplete:(void(^)(BaseButton *btn))complete{
    BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 35);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    complete(btn);
    return item;
}
@end
