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

//Font适配
UIKIT_STATIC_INLINE UIFont * BHFont(NSUInteger fontSize)
{
    return [UIFont systemFontOfSize:fontSize];
}

//整型转字符串
UIKIT_STATIC_INLINE NSString * BHIString(NSInteger f)
{
    return [NSString stringWithFormat:@"%ld",(long)f];
}

//浮点转字符串
UIKIT_STATIC_INLINE NSString * BHFString(CGFloat f)
{
    return [NSString stringWithFormat:@"%.2lf",f];
}

//浮点转字符串
UIKIT_STATIC_INLINE NSString * BHLFString(CGFloat f)
{
    return [NSString stringWithFormat:@"%lf",f];
}
#endif /* static_h */
