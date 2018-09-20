//
//  ForgetPwdThreeViewModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"
#import "ForgetPwdThreeDataModel.h"

@class ForgetPwdThreeController;

@interface ForgetPwdThreeViewModel : BaseObject

@property (nonatomic , assign) ForgetPwdThreeController *viewController;

@property (nonatomic , strong) ForgetPwdThreeDataModel *dataModel;

@property (nonatomic , strong) BaseTextField *pwd1TextField;

@property (nonatomic , strong) BaseTextField *pwd2TextField;

@property (nonatomic , strong) UIButton *submitBtn;

- (void)setupInitLayout;
@end
