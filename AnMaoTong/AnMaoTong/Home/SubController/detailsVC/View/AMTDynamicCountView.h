//
//  AMTDynamicCountView.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"
#import "AMTDynamicCountModel.h"
@interface AMTDynamicCountView : BaseView
@property (nonatomic, strong) BaseButton *commentBtn;
@property (nonatomic, strong) BaseButton *likeBtn;
@property (nonatomic, strong) BaseButton *collectionBtn;
@property (nonatomic, strong) BaseButton *browseBtn;
@property (nonatomic, strong) AMTDetailsModel *model;
@end
