//
//  AMTClassModel.h
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTClassModel : NSObject
@property (nonatomic, copy) NSArray <AMTZoneModel *>*zoneArray;
@property (nonatomic, copy) NSArray <AMTBrandModel *>*brandArray;
@end
