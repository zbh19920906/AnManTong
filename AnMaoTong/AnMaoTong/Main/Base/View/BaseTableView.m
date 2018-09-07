//
//  BaseTableView.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if (IS_IPHONE_X) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-43);
        }
        if (@available(iOS 11.0, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

@end
