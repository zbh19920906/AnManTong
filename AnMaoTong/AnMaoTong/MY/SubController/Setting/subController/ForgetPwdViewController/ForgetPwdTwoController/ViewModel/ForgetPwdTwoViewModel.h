//
//  ForgetPwdTwoViewModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/10.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"
#import "ForgetPwdTwoDataModel.h"

@class ForgetPwdTwoController;

@interface ForgetPwdTwoViewModel : BaseObject

@property (nonatomic , strong) ForgetPwdTwoDataModel *dataModel;

@property (nonatomic , assign) ForgetPwdTwoController *viewController;

@property (nonatomic , strong) BaseTextField *codeTextField;

@property (nonatomic , strong) UIButton *submitBtn;


- (void)setupInitLayout;
@end
