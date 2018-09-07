//
//  RegisterViewModel.h
//  yuexia
//
//  Created by 陈坚贞 on 2018/4/25.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseObject.h"
#import "CPLinkLabView.h"
@class RegisterViewController;


@interface RegisterViewModel : BaseObject

@property (nonatomic, strong) BaseTextField *phoneTextField;
@property (nonatomic, strong) BaseTextField *codeTextField;
@property (nonatomic, strong) BaseTextField *pswTextField;
@property (nonatomic, strong) UIButton *verifycodeBtn;
@property (nonatomic, strong) CPLinkLabView *linkLab;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, assign) RegisterViewController *viewController;

- (void)setUpLayout;

@end
