//
//  CPBottomPromitOption.h
//  测试
//
//  Created by lk03 on 2017/7/22.
//  Copyright © 2017年 KKJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CPBlurEffectStyleExtraLight,
    CPBlurEffectStyleLight
} CPBlurEffectStyle;

@interface CPBottomPromitOption : NSObject
/**title顶部间距*/
@property (nonatomic , assign) CGFloat  spacingForTitle_Top;
/**title左边间距*/
@property (nonatomic , assign) CGFloat  spacingForTitle_Left;
/**title右边间距*/
@property (nonatomic , assign) CGFloat  spacingForTitle_Right;

/**detail顶部间距*/
@property (nonatomic , assign) CGFloat  spacingForDetail_top;
/**detail左边间距*/
@property (nonatomic , assign) CGFloat  spacingForDetail_Left;
/**detail右边间距*/
@property (nonatomic , assign) CGFloat  spacingForDetail_Right;
/**detail底部间距*/
@property (nonatomic , assign) CGFloat  spacingForDetail_Bottom;

/**头标题顶部间距*/
@property (nonatomic , assign) CGFloat  spacingForHead_Top;
/**头标题左边间距*/
@property (nonatomic , assign) CGFloat  spacingForHead_Left;
/**头标题右边间距*/
@property (nonatomic , assign) CGFloat  spacingForHead_Right;
/**头标题底部间距*/
@property (nonatomic , assign) CGFloat  spacingForHead_Bottom;

/**头标题颜色*/
@property (nonatomic , strong) UIColor  *colorForHead;
/**头标题字体*/
@property (nonatomic , strong) UIFont   *fontForHead;

/**title颜色*/
@property (nonatomic , strong) UIFont   *titleFont;
/**title字体*/
@property (nonatomic , strong) UIFont   *detailFont;

/**取消栏高度*/
@property (nonatomic , assign) CGFloat  defCancleHeight;
/**取消烂的颜色*/
@property (nonatomic , strong) UIColor  *defCancleColor;

/**CPBottomPromitView显示的最大高度*/
@property (nonatomic , assign) CGFloat  max_height;

/**线的间距*/
@property (nonatomic , assign) UIEdgeInsets separatorInset;
/**线的颜色*/
@property (nonatomic , strong) UIColor      *separatorColor;
/**取消与选项中间视图的颜色*/
@property (nonatomic , strong) UIColor      *separatorViewColor;

//默认配置
+(instancetype)defaultOption;

@end
