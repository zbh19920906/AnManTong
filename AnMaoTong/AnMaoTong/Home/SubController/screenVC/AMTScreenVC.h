//
//  AMTScreenVC.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^ScreenBlock)(AMTBrandModel *model);
@interface AMTScreenVC : BaseViewController
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) ScreenBlock screenBlock;
@end
