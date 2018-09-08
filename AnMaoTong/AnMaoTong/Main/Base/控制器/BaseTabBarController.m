//
//  BaseTabBarController.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BHError.h"
#import <UserNotifications/UserNotifications.h>
#import "XYTabBar.h"
#import "AMTAddButtonVC.h"
#import "AMTMyVC.h"
#import "AMTFindVC.h"
#import "AMTHomeVC.h"
#import "AMTMessageVC.h"
@interface BaseTabBarController ()
<UITabBarControllerDelegate,
XYTabBarDelegate>


@end

@implementation BaseTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //错误收集
    [BHError requestError];
    self.delegate = self;
    AMTHomeVC *home = [[AMTHomeVC alloc] init];
    [self createChildVCWithVC:home Title:@"首页" Image:@"home" SelectedImage:@"home_pre"];
    
    AMTFindVC *find = [[AMTFindVC alloc] init];
    [self createChildVCWithVC:find Title:@"商品" Image:@"find" SelectedImage:@"find_pre"];
    
    AMTMessageVC *message = [[AMTMessageVC alloc] init];
    [self createChildVCWithVC:message Title:@"消息" Image:@"message" SelectedImage:@"message_pre"];
    
    AMTMyVC *profile = [[AMTMyVC alloc] init];
    [self createChildVCWithVC:profile Title:@"我的" Image:@"my" SelectedImage:@"my_pre"];
    
    XYTabBar *tabBar = [[XYTabBar alloc] init];
    tabBar.delegate = self;
    [[XYTabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self setValue:tabBar forKey:@"tabBar"];
    
}

- (void)createChildVCWithVC:(UIViewController *)childVC Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedimage
{
    //等价于
    childVC.title = title;//同时设置tabbar和navigation的标题
    //设置文字的样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *selectedtextAttrs = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor cz_ToUIColorByStr:@"C6C6C6"];
    selectedtextAttrs[NSForegroundColorAttributeName] = [UIColor cz_ToUIColorByStr:@"FF3658"];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    //设置子控制器的图片
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //这句话的意思是声明这张图片按照原始的样子显示出来，不要自动渲染成其他颜色
    
    //给子控制器包装导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
//    nav.navBar.titieLab.text = title;
    [self addChildViewController:nav];
}

#pragma mark - tabbar代理方法
- (void)tabBarDidClickPlusButton:(XYTabBar *)tabBar
{

}

#pragma mark --UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger idx = [self.childViewControllers indexOfObject:viewController];
    if (idx == 3) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[AMTLoginVC new]];
        [getWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    
    return YES;
}



@end

