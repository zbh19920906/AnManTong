//
//  AMTDetailsViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTDetailsModel.h"
#import "AMTCommentModel.h"
@interface AMTDetailsViewModel : NSObject
@property (nonatomic, strong) RACCommand *detailsCommand;
@property (nonatomic, strong) RACCommand *listCommand;
@property (nonatomic, strong) AMTDetailsModel *model;
@property (nonatomic, strong) NSMutableArray <AMTCommentModel *>*listArray;
@end
