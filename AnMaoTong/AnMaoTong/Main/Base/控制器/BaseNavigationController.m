//
//  BaseNavigationController.m
//  CloudMoto
//
//  Created by lk05 on 2017/10/23.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIButton * button;
@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setinSubViews];
}

-(void)setinSubViews
{
    //修改导航栏背景颜色
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName : [UIColor cz_ToUIColorByStr:@"333333"],
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES ) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
        
        //自定义返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"fanhui") style:UIBarButtonItemStyleDone target:self action:@selector(didTapBackButton)];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:YES];
    
    //解决tabar跳转时候的跳动问题
    if (IS_IPHONE_X) {
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = HEIGHT_SCREEN - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
    
}

- (void)didTapBackButton
{
    [super popViewControllerAnimated:YES];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
//    {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//
//    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
//
//        _button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//        _button.frame = CGRectMake(0, 0, 44, 44);
//        // 让按钮内部的所有内容左对齐
//        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        // 修改导航栏左边的item
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
//
//        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
//
//    }
//    [super pushViewController:viewController animated:YES];
//}
//
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
//{
//    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
//    {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return  [super popToRootViewControllerAnimated:animated];
//
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
//    {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return [super popToViewController:viewController animated:animated];
//
//}
//
//
//- (void)back
//{
//    [super popViewControllerAnimated:YES];
//}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
//    {
//        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ){
//            return NO;
//        }
//    }
//    return YES;
//}
@end
