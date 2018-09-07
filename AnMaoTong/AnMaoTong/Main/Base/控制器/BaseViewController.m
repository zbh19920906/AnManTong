//
//  BaseViewController.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
    
    if (@available(iOS 11.0, *)) {
    } else {
        //解决tableview往下偏移问题
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (self.navigationController) {
        [self setCustomNavigationBar];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.view bringSubviewToFront:self.navBar];
    }
}

- (void)setCustomNavigationBar
{
    self.navigationController.navigationBar.hidden = YES;

    //类目条
    [self.view addSubview:self.navBar];
    
    _navBar.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(NavHFit);
}

/**
 创建一个导航类目条
 
 @return BaseNavgationBar
 */
-(BaseNavgationBar*)navBar
{
    if (_navBar==nil) {
        _navBar = [[BaseNavgationBar alloc] init];
        _navBar.backgroundColor = [UIColor cz_ToUIColorByStr:@"#ffffff"];
        [_navBar.backButton addTarget:self action:@selector(clickBackButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_navBar.rightButton addTarget:self action:@selector(clickRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.navigationController.viewControllers.count == 1) {
            _navBar.backButton.hidden = YES;
        }
    }
    return _navBar;
}


- (void)dealloc
{
    [myNoti removeObserver:self];
}


- (BOOL)isUserLogin
{
    if ([UserHelper shareInstance].user.user_id.length == 0) {
        
        return NO;
    }
    return YES;
}


//返回按钮事件
- (void)clickBackButtonAcion:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右侧按钮
- (void)clickRightButtonAction:(id)sender
{
    
}

- (void)removeLeftButtonTarget
{
    [_navBar.backButton removeTarget:self action:@selector(clickBackButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
}

@end
