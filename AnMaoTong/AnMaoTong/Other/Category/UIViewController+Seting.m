//
//  UIViewController+Seting.m
//  JIaYou
//
//  Created by lk06 on 2017/4/12.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "UIViewController+Seting.h"

@implementation UIViewController (Seting)
/**
 *设置控制器的详情
 */
- (void)setingTabImage:(NSString *)defaultName
             imageName:(NSString *)selectedName
                titile:(NSString *)tiltleStr
              navTitle:(NSString *)navStr
{
    [self.tabBarItem setImage:[[UIImage imageNamed:defaultName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setTitle:tiltleStr];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cz_ToUIColorByStr:@"bbbbbb"]} forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cz_ToUIColorByStr:@"108bef"]} forState:UIControlStateSelected];
    self.navigationItem.title = navStr;
}
@end
