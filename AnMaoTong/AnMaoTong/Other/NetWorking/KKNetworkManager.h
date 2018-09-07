//
//  KKNetworkManager.h
//  CloudMoto
//
//  Created by XXF on 2017/11/3.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNetworkManager : NSObject

/**
 方法内Bolck回调
 
 @param isSuccess 是否成功
 @param json 回调信息
 */
typedef void(^Resultcompletion)(BOOL isSuccess, id json);



@end

