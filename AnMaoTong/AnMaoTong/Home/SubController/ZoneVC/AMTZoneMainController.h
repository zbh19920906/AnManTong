//
//  AMTZoneMainController.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface AMTZoneMainController : AMTKeyBoradController
@property (nonatomic, copy) NSString *goods_class_id;
@property (nonatomic, copy) NSString *zone_id;
@property (nonatomic, copy) NSString *brand_id;
- (void)setNotifi;
- (void)removeNotifi;
@end
