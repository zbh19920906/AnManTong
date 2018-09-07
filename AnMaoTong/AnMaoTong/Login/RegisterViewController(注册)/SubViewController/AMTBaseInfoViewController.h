//
//  AMTBaseInfoViewController.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "AMTRegisterModel.h"
@interface AMTBaseInfoViewController : BaseViewController
@property (nonatomic, strong) AMTRegisterModel *model;
@property (nonatomic, strong) BaseLabel *titleLab;
@property (nonatomic, strong) BaseButton *nextBtn;
@end
