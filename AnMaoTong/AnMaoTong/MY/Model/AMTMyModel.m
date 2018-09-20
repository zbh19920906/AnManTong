//
//  AMTMyModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTMyModel.h"

@implementation AMTMyModel
- (instancetype)init
{
    if (self = [super init]) {
        self.iconArr = @[@[@"评论",@"赞",@"浏览"],@[@"微信 (1)",@"QQ",@"客服 (1)",@"设置"]];
        self.titleArr = @[@[@"我的评论",@"我赞的",@"浏览历史"],@[@"微信客服",@"QQ客服",@"在线客服",@"设置"]];
    }
    return self;
}
@end
