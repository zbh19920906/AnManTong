//
//  static.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/6.
//  Copyright © 2018年 zhu. All rights reserved.
//

#ifndef static_h
#define static_h
//颜色
UIKIT_STATIC_INLINE UIColor * BHColor(NSString *colroStr)
{
    return [UIColor cz_ToUIColorByStr:colroStr];
}

//平方细体Font适配
UIKIT_STATIC_INLINE UIFont * BHFont(NSUInteger fontSize)
{
    return [UIFont systemFontOfSize:fontSize];
}

#endif /* static_h */
