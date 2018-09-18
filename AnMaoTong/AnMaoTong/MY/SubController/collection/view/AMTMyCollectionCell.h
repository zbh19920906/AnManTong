//
//  AMTMyCollectionCell.h
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AMTCollectionModel.h"
@interface AMTMyCollectionCell : BaseTableViewCell
@property (nonatomic, assign) BOOL isHistory;
@property (nonatomic, strong) AMTCollectionModel *model;
@end
