//
//  CPBottomPromitHeadView.h
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPBottomPromit.h"

@interface CPBottomPromitHeadView : UIView

/**初始化*/
+(__kindof CPBottomPromitHeadView *)bottomPromitHeadViewWithOption:(CPBottomPromitOption *)option;

/**写入头部数据*/
-(void)addHeadViewTitle:(NSString *)title option:(CPBottomPromitOption *)option complete:(void(^)())complete;
@end
