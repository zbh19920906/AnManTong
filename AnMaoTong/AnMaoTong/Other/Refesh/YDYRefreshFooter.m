//
//  YDYRefreshFooter.m
//  CloudMoto
//
//  Created by lk06 on 2018/7/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "YDYRefreshFooter.h"

@implementation YDYRefreshFooter

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.arrowView.image = imageNamed(@"xialashuaxin");
        [self setTitle:@"加载更多" forState:MJRefreshStateIdle];
        [self setTitle:@"释放加载" forState:MJRefreshStatePulling];
        [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
        [self setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
        self.stateLabel.font = [UIFont systemFontOfSize:14];
        self.labelLeftInset = 18;
    }
    return self;
}

@end
