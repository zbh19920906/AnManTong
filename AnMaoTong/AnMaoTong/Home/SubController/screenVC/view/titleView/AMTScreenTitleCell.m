//
//  AMTScreenTitleCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTScreenTitleCell.h"
@interface AMTScreenTitleCell ()

@end
@implementation AMTScreenTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _button  = [BaseButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor cz_ToUIColorByStr:@"f5f5f5"];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_button setTitleColor:[UIColor cz_ToUIColorByStr:@"FF3658"] forState:UIControlStateSelected];
        [_button setTitleColor:[UIColor cz_ToUIColorByStr:@"333333"] forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
        [self.contentView addSubview:_button];
        
        _button.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }
    return self;
}

@end
