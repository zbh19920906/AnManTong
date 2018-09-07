//
//  KKHistorySearchModel.h
//  CloudMoto
//
//  Created by lk03 on 2018/3/13.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKHistorySearchModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *storeID;

//商家经纬度
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;

@end
