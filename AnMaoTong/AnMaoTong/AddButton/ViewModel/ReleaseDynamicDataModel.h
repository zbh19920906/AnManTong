//
//  ReleaseDynamicDataModel.h
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseObject.h"

@interface ReleaseDynamicDataModel : BaseObject

@property (nonatomic , strong) NSMutableArray<UIImage *> *imageDataSource;

@property (nonatomic , assign) BOOL isBrand;

@property (nonatomic , strong) RACCommand *postAddUserDynamicCommand;

@property (nonatomic, strong) id locationPOI;
@end
