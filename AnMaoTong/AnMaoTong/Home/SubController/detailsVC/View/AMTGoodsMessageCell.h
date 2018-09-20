//
//  AMTGoodsMessageCell.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AMTDetailsModel.h"
@interface AMTGoodsMessageCell : BaseTableViewCell

@property (nonatomic, strong) AMTDetailsModel *model;
@property (nonatomic, strong) UITapGestureRecognizer *headTap;
- (void)changeComment:(AMTDetailsModel *)model;
- (void)changeCollection:(AMTDetailsModel *)model;
- (void)changeLike:(AMTDetailsModel *)model;
@end
