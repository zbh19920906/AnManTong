//
//  AMTPartitionView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/10.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"

@interface AMTPartitionView : BaseView
@property (nonatomic, strong) BaseLabel *titleLab;

@property (nonatomic, strong) BaseLabel *contentLab;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end
