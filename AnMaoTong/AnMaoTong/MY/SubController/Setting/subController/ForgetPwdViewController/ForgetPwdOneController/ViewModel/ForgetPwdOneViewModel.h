//
//  ForgetPwdOneViewModel.h
//  yuexia
//
//  Created by 陈平 on 2017/12/7.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "BaseObject.h"
#import "ForgetPwdOneDataModel.h"

@class ForgetPwdOneController;

@interface ForgetPwdOneViewModel : BaseObject

@property (nonatomic , strong) ForgetPwdOneDataModel *dataModel;

@property (nonatomic , assign) ForgetPwdOneController *viewController;

@property (nonatomic , strong) BaseTextField *phoneTextField;

@property (nonatomic , strong) UIButton *submitBtn;

@property (nonatomic , copy) NSString *currentTitle;

- (void)setupInitLayout;

@end
