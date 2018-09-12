//
//  AMTHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHeadView.h"
@interface AMTHeadView ()
@property (nonatomic, strong) BaseButton *oldButton;
@property (nonatomic, strong) BaseView *linkView;
@end
@implementation AMTHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    NSArray *titleArr = @[@"全部",@"供货",@"求购"];
    for (NSInteger i = 0; i < 3; i ++) {
        BaseButton *button = [BaseButton buttonWithType:UIButtonTypeCustom];
        [button setLableColor:@"959595" font:14 bold:1];
        [button setTitleColor:BHColor(@"222222") forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.tag = i + 10;
        button.frame = CGRectMake(114 + (27 +32)*i, 12, 35, 15);
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _oldButton = button;
        }
    }
    _linkView = [[BaseView alloc]init];
    _linkView.backgroundColor = BHColor(@"FF3658");
    [self addSubview:_linkView];
    _linkView.frame = CGRectMake(_oldButton.centerX - 11, self.height - 8, 22, 2);
}

- (void)click:(BaseButton *)button
{
    _oldButton.selected = NO;
    button.selected = YES;
    _oldButton = button;
    weakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.linkView.frame = CGRectMake(weakSelf.oldButton.centerX - 11, self.height - 8, 22, 2);
    }];
}
@end
