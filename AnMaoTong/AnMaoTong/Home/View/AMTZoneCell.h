//
//  AMTZoneCell.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AMTZoneCell : BaseTableViewCell
@property (nonatomic, copy) NSArray <AMTZoneModel *>*zoneArray;
- (void)goZoneVC:(BaseButton *)btn;
@end
