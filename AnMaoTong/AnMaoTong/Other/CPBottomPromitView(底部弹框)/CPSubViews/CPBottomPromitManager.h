//
//  CPBottomPromitManager.h
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBottomPromit.h"

@interface CPBottomPromitManager : NSObject
/**标题*/
@property (nonatomic , copy) NSString                           *title;
/**详细*/
@property (nonatomic , copy) NSString                           *detail;
/**标题颜色*/
@property (nonatomic , strong) UIColor                          *titleColor;
/**详细颜色*/
@property (nonatomic , strong) UIColor                          *detailColor;
/**高度*/
@property (nonatomic , assign , readonly) CGFloat               height;
/**配置*/
@property (nonatomic , strong , readonly) CPBottomPromitOption  *option;
/**是否是取消按钮*/
@property (nonatomic , assign , readonly) BOOL                  isCancle;
/**是否居中*/
@property (nonatomic , assign , readonly) BOOL                  isCenter;

/**初始化*/
+(instancetype)managerWithTitle:(NSString *)title
                         detail:(NSString *)detail
                     titleColor:(UIColor *)titleColor
                    detailColor:(UIColor *)detailColor
                         option:(CPBottomPromitOption *)option;

/**取消按钮初始化*/
+(instancetype)managerWithCancleWithOption:(CPBottomPromitOption *)option;;


/**
 保存按钮
 */
+(instancetype)managerWithSaveWithOption:(CPBottomPromitOption *)option;
@end
