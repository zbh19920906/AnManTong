//
//  BaseNavgationBar.h
//  YunDouYou
//
//  Created by lk06 on 2018/7/3.
//  Copyright © 2018年 lk06. All rights reserved.
//

#import "BaseView.h"
#import "BaseButton.h"

@interface BaseNavgationBar : BaseView

@property (nonatomic , strong) UILabel * titieLab;
@property (nonatomic , strong) BaseButton * backButton;
@property (nonatomic , strong) BaseView * lineView;
@property (nonatomic , strong) BaseButton * rightButton;

-(void)clearNav;

@end
