//
//  BHNavigationLeftBtn.m
//  JIaYou
//
//  Created by lk05 on 17/5/6.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "BHNavigationLeftBtn.h"
@interface BHNavigationLeftBtn ()

@end

@implementation BHNavigationLeftBtn

- (instancetype)initWithController:(UIViewController *)vc
{
    if (self = [super init]) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
        [_leftButton sizeToFit];
        // 让按钮内部的所有内容左对齐
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置内边距，让按钮靠近屏幕边缘
        _leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    }
    return self;
}

@end
