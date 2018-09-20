//
//  AMTContentView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"

@interface AMTContentView : BaseView
@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, strong) NSIndexPath *oldIndexPath;

- (void)reset;
@end
