//
//  AMTKeyBoardInputView.h
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"

@interface AMTKeyBoardInputView : BaseView
@property (nonatomic, strong) BaseTextField *inputTF;
@property (nonatomic, strong) BaseButton *determineBtn;
- (void)show:(CGFloat)height;
- (void)hidden;
@end
