//
//  CPBottomPromitOption.m
//  测试
//
//  Created by lk03 on 2017/7/22.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import "CPBottomPromitOption.h"

@implementation CPBottomPromitOption

+(instancetype)defaultOption{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.spacingForTitle_Top = 10;
        self.spacingForTitle_Left = 15;
        self.spacingForTitle_Right = 15;
        
        self.spacingForDetail_top = 5;
        self.spacingForDetail_Left = 10;
        self.spacingForDetail_Right = 10;
        self.spacingForDetail_Bottom = 10;
        
        self.spacingForHead_Top = 10;
        self.spacingForHead_Left = 10;
        self.spacingForHead_Right = 10;
        self.spacingForHead_Bottom = 10;
        
        self.fontForHead = [UIFont systemFontOfSize:15];
        self.colorForHead = [UIColor blackColor];
        
        self.titleFont = [UIFont systemFontOfSize:16];
        self.detailFont = [UIFont systemFontOfSize:13];
        
        self.defCancleHeight = 50;
        self.defCancleColor = [UIColor redColor];
        self.max_height = [UIScreen mainScreen].bounds.size.height - 50;
        
        self.separatorInset = UIEdgeInsetsZero;
        self.separatorColor = [[UIColor darkGrayColor] colorWithAlphaComponent:.3];
        self.separatorViewColor = [[UIColor darkGrayColor] colorWithAlphaComponent:.2];
    }
    return self;
}

@end
