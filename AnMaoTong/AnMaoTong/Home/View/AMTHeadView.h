//
//  AMTHeadView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"
typedef void (^HeadClick)(NSInteger tag);
@interface AMTHeadView : BaseView
@property (nonatomic, copy) HeadClick headClick;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray click:(HeadClick)click;
@end
