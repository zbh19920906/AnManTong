//
//  CALayer+KKCustomLayer.m
//  CloudMoto
//
//  Created by lk03 on 2018/7/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "CALayer+KKCustomLayer.h"

@implementation CALayer (KKCustomLayer)

//底部线条
+ (CALayer *)bottomLayerWithWidth:(CGFloat)width height:(CGFloat)height
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, height, width, 0.5);
    bottomBorder.backgroundColor = [UIColor cz_ToUIColorByStr:@"eeeeee"].CGColor;
    
    return bottomBorder;
}

//顶部线条
+ (CALayer *)topLayerWithWidth:(CGFloat)width height:(CGFloat)height
{
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, width, 0.5);
    topBorder.backgroundColor = [UIColor cz_ToUIColorByStr:@"eeeeee"].CGColor;
    
    return topBorder;
}

@end
