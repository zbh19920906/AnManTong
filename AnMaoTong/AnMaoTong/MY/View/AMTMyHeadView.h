//
//  AMTMyHeadView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"
#import "AMTMyModel.h"
@interface AMTMyHeadView : BaseView
@property (nonatomic, strong) AMTMyModel *model;
@property (nonatomic, strong) BaseButton *changeBtn;

- (void)changeUI;
@end
