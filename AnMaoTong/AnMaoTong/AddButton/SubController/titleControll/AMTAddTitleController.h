//
//  AMTAddTitleController.h
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^saveBlock)(NSString *titles);
@interface AMTAddTitleController : BaseViewController
@property (nonatomic, copy) saveBlock saveBlock;
@end
