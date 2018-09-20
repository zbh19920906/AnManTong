//
//  AMTHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTHeadView.h"
@interface AMTHeadView ()
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) BaseButton *oldButton;
@property (nonatomic, strong) BaseView *linkView;
@end
@implementation AMTHeadView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray click:(id)click
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.headClick = click;
        _titleArr = titleArray;
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    for (NSInteger i = 0; i < _titleArr.count; i ++) {
        BaseButton *button = [BaseButton buttonWithType:UIButtonTypeCustom];
        [button setLableColor:@"959595" font:14 bold:1];
        [button setTitleColor:BHColor(@"222222") forState:UIControlStateSelected];
        [button setTitle:_titleArr[i] forState:UIControlStateNormal];
        button.tag = i + 10;
        CGSize size = [NSObject sizeWithFont:BHFont(14) Text:_titleArr[i] MaxSize:CGSizeMake(self.size.width, MAXFLOAT)];
        CGFloat X = (WIDTH_SCREEN - (35 *_titleArr.count + 27 *(_titleArr.count-1)))/2;
        button.frame = CGRectMake(X + (27 +32)*i, 12, size.width, 15);
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
    self.headClick ? self.headClick(button.tag - 10) : nil;
    weakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.linkView.frame = CGRectMake(weakSelf.oldButton.centerX - 11, self.height - 8, 22, 2);
    }];
}
@end
