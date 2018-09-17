//
//  AMTKeyBoradController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTKeyBoradController.h"

@interface AMTKeyBoradController ()

@end

@implementation AMTKeyBoradController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [getWindow addSubview:self.keyBoardInputView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [myNoti removeObserver:self];
    self.keyBoardInputView.inputView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBingding];
    self.keyBoardInputView.inputView.hidden = NO;
}

- (void)setBingding
{
    
}

- (AMTKeyBoardTextView *)keyBoardInputView
{
    if (!_keyBoardInputView) {
        _keyBoardInputView = [[AMTKeyBoardTextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    }
    return _keyBoardInputView;
}

@end
