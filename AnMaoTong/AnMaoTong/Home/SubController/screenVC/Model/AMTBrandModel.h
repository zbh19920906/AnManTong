//
//  AMTBrandModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseModel.h"

@interface AMTBrandModel : BaseModel
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * icon_img;
@property (nonatomic, copy) NSString * goods_class_id;
@property (nonatomic, copy) NSString * sort;
@property (nonatomic, copy) NSString * status;
@end
