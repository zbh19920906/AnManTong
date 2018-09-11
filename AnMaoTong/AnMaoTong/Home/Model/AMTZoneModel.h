//
//  AMTZoneModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTZoneModel : BaseModel
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 专区名
 */
@property (nonatomic, copy) NSString *name;
/**
 专区图片
 */
@property (nonatomic, copy) NSString *img_url;
/**
 id
 */
@property (nonatomic, assign) NSInteger type;
@end
