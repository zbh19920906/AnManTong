//
//  YDYRefreshHeader.m
//  CloudMoto
//
//  Created by lk06 on 2018/7/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "YDYRefreshHeader.h"

@implementation YDYRefreshHeader

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
        [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
        weakSelf(self);
        self.beginRefreshingCompletionBlock = ^{
            [weakSelf setTitle:@"刷新成功" forState:MJRefreshStateIdle];
        };
        self.endRefreshingCompletionBlock = ^{
            [weakSelf setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        };
        self.stateLabel.font = [UIFont systemFontOfSize:14];
        self.arrowView.image = imageNamed(@"xialashuaxin");
        self.labelLeftInset = 18;
        self.lastUpdatedTimeLabel.hidden = YES;
    }
    return self;
}
@end
