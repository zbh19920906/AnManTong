//
//  AMTDetailsClassView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsClassView.h"

@implementation AMTDetailsClassView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.backgroundColor = [UIColor redColor];
}

@end
