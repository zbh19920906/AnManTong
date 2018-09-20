//
//  AMTMyLikeViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTMyCommentModel.h"
@interface AMTMyLikeViewModel : NSObject
@property (nonatomic, strong) RACCommand *likeCommand;
@property (nonatomic, strong) RACCommand *commentCommand;
@property (nonatomic, strong) NSMutableArray *listArr;
@end
