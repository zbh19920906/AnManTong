//
//  AMTPersonalCell.h
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface AMTPersonalCell : BaseTableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isUser;
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseTextField *rightTF;
@property (nonatomic, strong) BaseButton *rightBtn;
@end
