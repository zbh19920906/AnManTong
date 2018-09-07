//
//  RegisterViewController.h
//  yuexia
//
//  Created by 陈坚贞 on 2018/4/23.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseViewController.h"

@class RegisterViewModel;
@class LoginDataModel;
typedef NS_ENUM(NSInteger, RegisterType) {
    RegisterUser = 1,
    RegisterMerchants = 2,
};
@interface RegisterViewController : BaseViewController

@property (nonatomic, strong) RegisterViewModel *registerViewModel;

/**
 数据层
 */
@property (nonatomic , strong) LoginDataModel *dataModel;
@property (nonatomic, assign) RegisterType type;
@end
