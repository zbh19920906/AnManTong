//
//  AMTReleaseViewModel.h
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTClassModel.h"
@interface AMTReleaseViewModel : NSObject
@property (nonatomic, strong) RACCommand *zoneCommand;
@property (nonatomic, strong) RACCommand *brandCommand;
@property (nonatomic, strong) RACCommand *releaseCommand;
@property (nonatomic, strong) AMTClassModel *model;

@property (nonatomic, copy) NSString *zoneID;
@property (nonatomic, copy) NSString *brandID;
@property (nonatomic, copy) NSString *position;
@end
