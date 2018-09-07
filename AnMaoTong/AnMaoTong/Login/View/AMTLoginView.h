//
//  AMTLoginView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"

@interface AMTLoginView : BaseView
@property (nonatomic, weak) id delegate;
@end
@protocol AMTLoginViewDelegate <NSObject>
- (void)LoginClick:(NSInteger)tag;
@end
