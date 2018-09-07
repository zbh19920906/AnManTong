//
//  BaseViewController.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavgationBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic , strong)BaseNavgationBar * navBar;

//是否登录
- (BOOL)isUserLogin;

//返回按钮
- (void)clickBackButtonAcion:(id)sender;
//右侧按钮
- (void)clickRightButtonAction:(id)sender;
- (void)removeLeftButtonTarget;
#pragma mark - 跳转到他人主页
- (void)gotoWeiboPersonVC:(NSString *)userID;

@end
