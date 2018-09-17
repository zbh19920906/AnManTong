//
//  AMTKeyBoardTextView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"

@interface AMTKeyBoardTextView : BaseView
@property (nonatomic, strong) BaseTextField *inputTF;
@property (nonatomic, strong) BaseView *inputView;
- (void)show:(CGFloat)height;
- (void)hidden;
@end
