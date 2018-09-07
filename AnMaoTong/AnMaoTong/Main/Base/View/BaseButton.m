//
//  BaseButton.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (void)animation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.values = @[@1.4, @1.0];
    
    animation.duration = 0.3;
    
    animation.calculationMode = kCAAnimationCubic;
    
    [self.layer addAnimation:animation forKey:@"transform.scale"];
    
}

- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
