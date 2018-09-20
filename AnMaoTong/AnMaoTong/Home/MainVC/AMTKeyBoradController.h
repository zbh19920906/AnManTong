//
//  AMTKeyBoradController.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "AMTKeyBoardTextView.h"
@interface AMTKeyBoradController : BaseViewController
@property (nonatomic, strong) AMTKeyBoardTextView *keyBoardInputView;
- (void)removeNotifi;
- (void)setNotifi;
- (void)sendComment;
@end
