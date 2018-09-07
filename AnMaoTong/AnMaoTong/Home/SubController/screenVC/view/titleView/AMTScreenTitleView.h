//
//  AMTScreenTitleView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"
typedef void (^ChangeItemBlock)(AMTGoodsClassModel *model);
@interface AMTScreenTitleView : BaseView
@property (nonatomic, copy) ChangeItemBlock changeItemBlock;
@property (nonatomic, copy) NSArray *titles;
- (instancetype)initWithFrame:(CGRect)frame changeItemBlock:(ChangeItemBlock)changeItemBlock;
@end
