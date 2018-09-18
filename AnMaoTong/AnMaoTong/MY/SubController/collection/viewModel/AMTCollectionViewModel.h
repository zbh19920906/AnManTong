//
//  AMTCollectionViewModel.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/18.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTCollectionModel.h"
@interface AMTCollectionViewModel : NSObject
@property (nonatomic, strong) RACCommand *collectionCommand;
@property (nonatomic, strong) NSMutableArray *listArr;
@end
