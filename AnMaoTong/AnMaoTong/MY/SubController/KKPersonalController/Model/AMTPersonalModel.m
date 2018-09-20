
//
//  AMTPersonalModel.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalModel.h"

@implementation AMTPersonalModel
- (instancetype)init
{
    if (self = [super init]) {
        User *user = [UserHelper shareInstance].user;
        self.sex = user.sex;
        self.wx = user.wx;
        self.qq = user.qq;
        self.name = user.name;
        self.nickname = user.nickname;
        self.date_birth = user.date_birth;
        self.announcement = user.announcement;
    }
    return self;
}
@end
