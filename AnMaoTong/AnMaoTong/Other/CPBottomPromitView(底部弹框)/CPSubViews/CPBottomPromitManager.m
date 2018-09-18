//
//  CPBottomPromitManager.m
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPBottomPromitManager.h"

@implementation CPBottomPromitManager

+(instancetype)managerWithTitle:(NSString *)title
                         detail:(NSString *)detail
                     titleColor:(UIColor *)titleColor
                    detailColor:(UIColor *)detailColor
                         option:(CPBottomPromitOption *)option{
    return [[self alloc] initWithTitle:title detail:detail titleColor:titleColor detailColor:detailColor option:option isCancle:NO];
}

+(instancetype)managerWithCancleWithOption:(CPBottomPromitOption *)option{
    NSString *cancleStr = @"取消";
    return [[self alloc] initWithTitle:cancleStr detail:nil titleColor:option.defCancleColor detailColor:nil option:option isCancle:YES];
}

+(instancetype)managerWithSaveWithOption:(CPBottomPromitOption *)option{
    NSString *saveStr = @"保存";
     return [[self alloc] initWithTitle:saveStr detail:nil titleColor:[UIColor whiteColor] detailColor:nil option:option isCancle:NO];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                   titleColor:(UIColor *)titleColor
                  detailColor:(UIColor *)detailColor
                       option:(CPBottomPromitOption *)option
                     isCancle:(BOOL)isCancle
{
    self = [super init];
    if (self) {
        self.title = title;
        self.detail = detail;
        
        self.titleColor = titleColor;
        self.detailColor = detailColor;
        
        _isCancle = isCancle;
        _isCenter = self.detail == nil ? YES : NO;
        _option = option;
        _height = [self getMangerHeightWithOption:option];
    }
    return self;
}

-(CGFloat)getMangerHeightWithOption:(CPBottomPromitOption *)option{
    CGFloat titleHeight = [self.title boundingRectWithSize:CGSizeMake(CPBP_ScreenSize.width - option.spacingForTitle_Left - option.spacingForTitle_Right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:option.titleFont} context:nil].size.height;
    CGFloat detailHeight = [self.detail boundingRectWithSize:CGSizeMake(CPBP_ScreenSize.width - option.spacingForDetail_Left - option.spacingForDetail_Right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:option.detailFont} context:nil].size.height;
    
    CGFloat height = titleHeight + detailHeight + option.spacingForTitle_Top + option.spacingForDetail_top + option.spacingForDetail_Bottom;
    if (_isCancle) {
        height = option.defCancleHeight;
    }
    
    return height;
}


@end
