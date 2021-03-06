//
//  BHGuideVC.m
//  JIaYou
//
//  Created by lk05 on 17/5/10.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "BHGuideVC.h"

@interface BHGuideVC ()

@end

@implementation BHGuideVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSubView];
    [UIApplication sharedApplication].statusBarHidden  = YES;
}

- (void)setSubView
{
    UIImageView * bgImage = [[UIImageView alloc]init];
    bgImage.image = imageNamed(@"guide_page");
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setLableColor:@"ffffff" font:18 bold:0];
    [button setTitle:@"立即开启" forState:UIControlStateNormal];
    [button setBackgroundImage:imageNamed(@"btn_bg") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClokc) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[bgImage,button]];
    
    
    bgImage.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    button.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,55)
    .widthIs(175)
    .heightIs(48);
}

- (void)buttonClokc
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:@"ThisNotFirstTime"];
    [userDefault synchronize];
    [UIApplication sharedApplication].statusBarHidden  = NO;
    BaseTabBarController *tabBarVC = [[BaseTabBarController alloc]init];
    getWindow.rootViewController =  tabBarVC;
   
}

@end
